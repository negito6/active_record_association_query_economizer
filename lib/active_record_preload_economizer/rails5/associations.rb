require 'active_record/associations/builder/association'
require 'active_record/associations/preloader/association'

module ActiveRecord
  module Associations
    module Builder
      class Association #:nodoc:
        VALID_OPTIONS += [:preload_if]
      end
    end

    class Preloader
      class Association #:nodoc:
        def preload_filters
          [options[:preload_if]].flatten.compact
        end

        def owners_filtered
          unless defined?(@owners_filtered)
            @owners_filtered = owners.dup
            preload_filters.each do |filter|
              case filter
              when Proc
                @owners_filtered.select!(&filter)
              when Symbol
                @owners_filtered.select! { |record| record.send(filter) }
              end
            end
          end
          @owners_filtered
        end

        def owner_keys
          unless defined?(@owner_keys)
            @owner_keys = owners_filtered.map do |owner|
              owner[owner_key_name]
            end
            @owner_keys.uniq!
            @owner_keys.compact!
          end
          @owner_keys
        end
      end
    end
  end
end
