module RbacCore
  class PermissionSet < OptionsModel
    class << self
      def finalized?
        @finalized ||= false
      end

      def append_draw(&block)
        append << block
      end

      def draw(&block)
        unless block_given?
          raise ArgumentError, "must provide a block"
        end
        if finalized?
          raise RuntimeError, "Permission Set has been finalized"
        end

        [block].concat(append).each do |blk|
          Mapper.new(self).instance_exec(&blk)
        end

        @finalized = true

        nil
      end

      def name
        @_name ||= "PermissionSet"
      end

      def name=(value)
        value = value.classify
        raise ArgumentError, "`value` isn't a valid class name" if value.blank?

        @_name = value
      end

      private

      def append
        @append ||= []
      end
    end
  end
end
