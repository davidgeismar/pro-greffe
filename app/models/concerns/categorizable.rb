module Categorizable
  extend ActiveSupport::Concern

  # Module that is added to all the class that need an alert system reporting errors.
  # Add an alerts has_many associations
  included do
    has_many :categorizings, as: :categorizable, dependent: :destroy
    has_many :categories, through: :categorizings
  end

  class << self
    attr_reader :included_classes
  end

  @included_classes = []

  # Get alerts
  def get_categories
    return self.categories
  end

  # Categories in string
  def all_categories
    self.categories.pluck(:name).join(' | ')
  end

  # First category name
  def first_category_name
    self.categories.first.try(:name)
  end

  # First category
  def first_category
    self.categories.first
  end

  def has_category?
    return !self.categories.empty?
  end

  def add_alert(description)
    self.alerts.create(:description => description)
  end

  # Attribute writer of tag ids
  def category_ids
    @category_ids || self.categories.pluck(:id)
  end

  # Callback that saves cuisine association
  def save_category_ids
    if @category_ids
      array = @category_ids.delete_if {|category| category.blank? }.delete_if{|category| Category.find_by_id(category.to_s.to_i).nil? }
      array = array.map {|category| Category.find_by_id(category.to_s.to_i)}
      self.categories = array
    end
  end

  # Add a category by the name and the type
  def add_category(name, type)
    category = Category.find_by(name: name.to_s.strip)
    if category.nil?
      category = Category.create(name: name.to_s.strip, type: type.to_s)
    end
    begin
    self.categories << category
    self.save
    rescue

    end
  end

  # Rewrite the included class that is maybe in Active support Concnern
  def self.included(subclass)
    Categorizable.included_classes << subclass.name
    # Extend the subclass with the class method
    subclass.extend(ClassMethods)
  end

  module ClassMethods

    # def included(subclass)
    #   Categorizable.included_classes << self.class.name
    # end

    # Search with category
    def search_by_category(category_id)
      category = Category.find_by(id: category_id.to_i)
      if category.nil?
        return self.all
      else
        category_ids = self.joins(:categories).where('categories.id = ?', category.id).pluck(:id).uniq
        return self.where("#{table_name}.id IN (?)", category_ids)
      end
    end
  end
end
