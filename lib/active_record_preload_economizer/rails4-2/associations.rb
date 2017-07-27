require 'active_record/associations/builder/association'
require 'active_record/associations/preloader/association'

module ActiveRecord
  module Associations
    module Builder
      class Association #:nodoc:
        self.valid_options += [:preload_if]
      end
    end
    class Preloader
      class Association #:nodoc:
        def preload_filters
          [options[:preload_if]].flatten.compact
        end

        remove_method :records_for
        def records_for(ids)
          filtered = ids.select do |key|
            records = owners_by_key[key]
            preload_filters.each do |filter|
              case filter
              when Proc
                records.select!(&filter)
              when Symbol
                records.select! { |record| record.send(filter) }
              end
            end
            records.present?
          end
          query_scope(filtered)
        end
      end
    end
  end
end
