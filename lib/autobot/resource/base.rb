require_relative './query_methods'

module Autobot
  module Resource
    class Base
      extend QueryMethods

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

      def initialize(attributes = {})
        attributes.each do |attr_name, value|
          method_name = "#{attr_name}="
          public_send(method_name, value) if respond_to?(method_name)
        end
      end
    end
  end
end
