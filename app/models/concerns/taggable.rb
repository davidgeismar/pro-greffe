module Taggable
  extend ActiveSupport::Concern

  # Module that is added to all the class that need an alert system reporting errors.
  # Add an alerts has_many associations
  included do
    has_many :taggings, as: :taggable, dependent: :destroy
    has_many :tags, through: :taggings
    after_save :save_tag_ids
  end

  class << self
    # Callbacks
    #attr_writer :tags_list
  end

  # Get all the articles link to the taggable through tags
  def related_articles
    tag_ids = self.tags.pluck(:id)
    article_ids = Tagging.where('taggings.taggable_type = ? AND taggings.tag_id IN (?)', "Article", tag_ids).pluck(:taggable_id)
    return Article.visible.where('articles.id IN (?)', article_ids)
  end

  # Get all the greffes link to the taggable through tags
  def related_greffes
    tag_ids = self.tags.pluck(:id)
    article_ids = Tagging.where('taggings.taggable_type = ? AND taggings.tag_id IN (?)', "greffe", tag_ids).pluck(:taggable_id)
    return greffe.where('greffes.id IN (?)', article_ids)
  end

  # Get all the media link to the taggable through tags
  def related_media
    tag_ids = self.tags.pluck(:id)
    article_ids = Tagging.where('taggings.taggable_type = ? AND taggings.tag_id IN (?)', "Medium", tag_ids).pluck(:taggable_id)
    return Medium.where('media.id IN (?)', article_ids)
  end

  # tags in string
  def all_tags
    self.tags.pluck(:name).join(' | ')
  end

  # First tag name
  def first_tag_name
    self.tags.first.try(:name)
  end

  # First tag
  def first_tag
    self.tags.first
  end

  def tags_list=(value)
    @tags_list = value
  end

  def tags_list
    @tags_list || self.tags.pluck(:name).join(",")
  end

  # Callback that saves tags association
  def save_tag_ids
    if @tags_list
      tags_array = self.tags_list.split(',')
      tag_ids = []

      tags_array.each do |name|
        tag = Tag.find_or_create_by(name: Tag.sanitize_name(name))
        tag_ids << tag.id
      end
      self.tag_ids = tag_ids.uniq
    else
      puts "NO TAGS ENTERED"
    end
  end


  module ClassMethods

    # def included(subclass)
    #   Categorizable.included_classes << self.class.name
    # end

    # Search with tag
    def search_by_tag(tag_id)
      tag = Tag.find_by(id: tag_id.to_i)
      if tag.nil?
        return self.all
      else
        tag_ids = self.joins(:tags).where('tags.id = ?', tag.id).pluck(:id).uniq
        return self.where("#{table_name}.id IN (?)", tag_ids)
      end
    end

    # Search with tag
    def search_by_tag_name(tag_name)
      tag = Tag.find_by(name: tag_name.to_s)
      if tag.nil?
        return self.all
      else
        tag_ids = self.joins(:tags).where('tags.id = ?', tag.id).pluck(:id).uniq
        return self.where("#{table_name}.id IN (?)", tag_ids)
      end
    end

    # Get all the articles link to a set of taggable
    def related_articles
      tag_ids = Tagging.where('taggings.taggable_type = ? AND taggings.taggable_id IN (?)', self.class.name, self.pluck(:id)).pluck(:tag_id).uniq
      article_ids = Tagging.where('taggings.taggable_type = ? AND taggings.tag_id IN (?)', "Article", tag_ids).pluck(:taggable_id)
      return Article.visible.where('articles.id IN (?)', article_ids)
    end

  end
end
