require_relative './query_methods'
require_relative '../concerns/initializable_with_attribute_values'

module Autobot
  module Resource
    class Base
      extend QueryMethods
      include Concerns::InitializableWithAttributeValues

      attr_accessor :id

      unless respond_to?(:class_name)
        def self.class_name
          name.split('::').last
        end
      end

      def self.from_json(json)
        attributes = json.map do |key, value|
          key_without_prefix = key.sub(/\A#{class_name.downcase}/, '')
          [key_without_prefix.underscore, value]
        end

        new(attributes)
      end
    end
  end
end
