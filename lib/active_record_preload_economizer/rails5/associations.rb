require 'active_record/associations/builder/association'
require 'active_record/associations/preloader/association'

module ActiveRecord
  module Associations
    module Builder
      class Association #:nodoc:
      end
    end

    class Preloader
      class Association #:nodoc:
        def owner_keys
          unless defined?(@owner_keys)
            @owner_keys = owners.map do |owner|
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
