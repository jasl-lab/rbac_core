module RBACCore
  class OptionsModel
    include ActiveModel::Model
    include Concerns::OptionsModel::Serialization
    include Concerns::OptionsModel::Attributes
    include Concerns::OptionsModel::AttributeAssignment

    validate do
      self.class.attribute_names.each do |attribute_name|
        attribute = public_send(attribute_name)
        if attribute.is_a?(OptionsModel) && attribute.invalid?
          errors.add attribute_name, :invalid
        end
      end
    end

    def inspect
      "#<#{self.class} #{self.to_h}>"
    end

    def self.inspect
      "#<#{self} [#{attribute_names.map(&:inspect).join(', ')}]>"
    end

    def persisted?
      true
    end
  end

end
