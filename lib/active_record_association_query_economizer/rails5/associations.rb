require 'active_record/associations/builder/association'
require 'active_record/associations/preloader/association'

module ActiveRecord
  module Associations
    module Builder
      class Association #:nodoc:
        VALID_OPTIONS += [:only]
      end
    end

    class Association #:nodoc:
      def association_filters
        [options[:only]].flatten.compact
      end

      def associated?
        association_filters.all? do |filter|
          case filter
          when Proc
            filter.call(owner)
          when Symbol
            owner.send(filter)
          end
        end
      end

      def load_target
        @target = find_target if associated? && ((@stale_state && stale_target?) || find_target?)

        loaded! unless loaded?
        target
      rescue ActiveRecord::RecordNotFound
        reset
      end
    end
    class CollectionAssociation < Association #:nodoc:
      def load_target
        if !associated?
          @target = []
        elsif find_target?
          @target = merge_target_lists(find_target, target)
        end

        loaded!
        target
      end
      def size
        if !associated?
          return 0
        elsif !find_target? || loaded?
          if association_scope.distinct_value
            target.uniq.size
          else
            target.size
          end
        elsif !loaded? && !association_scope.group_values.empty?
          load_target.size
        elsif !loaded? && !association_scope.distinct_value && target.is_a?(Array)
          unsaved_records = target.select { |r| r.new_record? }
          unsaved_records.size + count_records
        else
          count_records
        end
      end
    end

    class Preloader
      class Association #:nodoc:
        def association_filters
          [options[:only]].flatten.compact
        end

        def owners_filtered
          unless defined?(@owners_filtered)
            @owners_filtered = owners.dup
            association_filters.each do |filter|
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

        remove_method :owner_keys
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
