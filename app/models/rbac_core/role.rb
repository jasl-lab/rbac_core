module RbacCore
  class Role < ApplicationRecord
    has_many :assignments, dependent: :destroy, inverse_of: :role
    has_many :subjects, through: :assignments

    serialize :permissions, PermissionList

    validates :name,
              presence: true

    def permissions=(object)
      value =
        if object.is_a? PermissionList
          object
        elsif object.respond_to?(:to_h)
          PermissionList.new object.to_h
        else
          raise "Attribute was supposed to be a #{PermissionList} or could respond to to_h, but was a #{object.class}. -- #{object.inspect}"
        end

      write_attribute :permissions, value
    end

    def builtin?
      false
    end
  end
end
