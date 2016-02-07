module Autobot
  module Concerns
    module InitializableWithAttributeValues
      def initialize(attributes = {})
        super()

        attributes.each do |attr_name, value|
          method_name = "#{attr_name}="
          public_send(method_name, value) if respond_to?(method_name)
        end
      end
    end
  end
end
