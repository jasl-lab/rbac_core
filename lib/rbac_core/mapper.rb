module RbacCore
  class Mapper
    def initialize(set) #:nodoc:
      @set = set
    end

    def permission(name, _options = {}, &_block)
      raise ArgumentError, "`name` can't be blank" if name.blank?

      @set.attribute(name, :boolean, default: false)

      self
    end

    def group(name, _options = {}, &block)
      raise ArgumentError, "`name` can't be blank" if name.blank?
      raise ArgumentError, "must provide a block" unless block_given?

      sub_permission_set_class = Class.new(PermissionSet)
      sub_permission_set_class.name = "#{name.to_s.classify}PermissionSet"
      sub_permission_set_class.draw(&block)

      @set.has_one(name, anonymous_class: sub_permission_set_class)

      self
    end
  end
end
