## Module that contains all the common methods that can be shared through all class

module PaginateSearch
  extend ActiveSupport::Concern

  included do
    scope :next_and_previous_record, ->(ordering_column = column_order_by) {
      select("#{table_name}.*").
      select("lag(id,1) over (order by #{ordering_column} desc) as previous_record, lead(id,1) over (order by #{ordering_column} desc) as next_record")
    }

    define_method "next_#{model_name.singular}" do
      read_attribute(:next_record)
    end

    define_method "previous_#{model_name.singular}" do
      read_attribute(:previous_record)
    end
  end

  module ClassMethods
    # Search and paginate
    def search_and_paginate(params)
      filter_search(params).paginate(page: params[:page], per_page: 99)
    end

    # Just the basic filter search
    def filter_search(attributes)
      # TODO CHANGE because to _unsafe h permits to inject all the things of attributes
      attributes.to_unsafe_h.inject(self) do |scope, (key, value)|
        # return scope.scoped if value.blank?
        if value.blank?
          scope.all
        else
          case key.to_sym
          when :order # order=field-(ASC|DESC)
            attribute, order = value.split('-')
            scope.order("#{table_name}.#{attribute} #{order}")

          else # unknown key (do nothing or raise error, as you prefer to)
            scope.all
          end

        end
      end
    end

    # Column to order the next and previous instances
    def column_to_order_by(column)
      @@column_order_by = column || "updated_at"

      define_method(:column_order_by) do
        @@column_order_by
      end
    end

    # Getter of the column order by
    def column_order_by
      @@column_order_by
    end

  end
end
