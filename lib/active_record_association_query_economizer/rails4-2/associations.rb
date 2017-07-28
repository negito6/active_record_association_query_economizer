require 'active_record/associations/builder/association'
require 'active_record/associations/preloader/association'

module ActiveRecord
  module Associations
    module Builder
      class Association #:nodoc:
        self.valid_options += [:only]
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
          # owners_by_key is: {1=>[#<SourceModel ...>, 2=>[#<SourceModel ...>], ...}
          owners_by_key.select do |key, records|
            association_filters.each do |filter|
              case filter
              when Proc
                records.select!(&filter)
              when Symbol
                records.select! { |record| record.send(filter) }
              end
            end
            records.present?
          end
        end

        remove_method :associated_records_by_owner
        def associated_records_by_owner(preloader)
          owners_map = owners_filtered
          owner_keys = owners_map.keys.compact

          # Each record may have multiple owners, and vice-versa
          records_by_owner = owners.each_with_object({}) do |owner,h|
            h[owner] = []
          end

          if owner_keys.any?
            # Some databases impose a limit on the number of ids in a list (in Oracle it's 1000)
            # Make several smaller queries if necessary or make one query if the adapter supports it
            sliced  = owner_keys.each_slice(klass.connection.in_clause_length || owner_keys.size)

            records = load_slices sliced
            records.each do |record, owner_key|
              owners_map[owner_key].each do |owner|
                records_by_owner[owner] << record
              end
            end
          end

          records_by_owner
        end
      end
    end
  end
end
