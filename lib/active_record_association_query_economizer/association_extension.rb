module ActiveRecordAssociationQueryEconomizer
  class AssociationExtension
    def valid_options
      [:preload_if]
    end

    def build(model, reflection)
      # nothing to do
    end
  end
end
