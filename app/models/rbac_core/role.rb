module RbacCore
  class Role < ApplicationRecord
    has_many :assignments, dependent: :destroy, inverse_of: :role
    has_many :subjects, through: :assignments

    serialize :permissions, PermissionSet

    validates :name,
              presence: true

    def permissions=(object)
      value =
        if object.is_a? PermissionSet
          object
        elsif object.respond_to?(:to_h)
          PermissionSet.new object.to_h
        else
          raise "Attribute was supposed to be a #{PermissionSet} or could respond to to_h, but was a #{object.class}. -- #{object.inspect}"
        end

      write_attribute :permissions, value
    end

    def builtin?
      false
    end
  end
end
