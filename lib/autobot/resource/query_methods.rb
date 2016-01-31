require_relative './collection'
require_relative './connection'

module Autobot
  module Resource
    module QueryMethods
      include Connection

      def where(condition)
        params = parameterize(condition).merge(
          offset_key => 1,
          direction: 'NEXT',
          limit: 100
        )

        Resource::Collection.new(self, :from_json) do |yielder|
          loop do
            json = perform_request(params)
            next_offset = json["next#{offset_key}"]
            json[class_name.downcase.pluralize].each { |hash| yielder << hash }

            break unless next_offset
            params[offset_key] = next_offset
          end
        end
      end

      private

      def offset_key
        "#{class_name}Id"
      end

      def parameterize(condition)
        condition
          .with_indifferent_access
          .select { |key| key == key.underscore }
          .transform_keys { |key| key.camelize(:lower) }
      end
    end
  end
end
