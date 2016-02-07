require 'faraday'
require 'json'

module Autobot
  module Resource
    module Connection
      ORIGIN = 'http://7gogo.jp'.freeze

      private

      def establish_connection(path)
        @path = path || ''
      end

      def connection
        @connection ||= ::Faraday::Connection.new(url: ORIGIN) do |faraday|
          faraday.request(
            :retry,
            max: 3,
            interval: 0.05,
            exceptions: ::Timeout::Error
          )

          faraday.request(:url_encoded)
          faraday.adapter(::Faraday.default_adapter)
        end
      end

      def perform_request(params)
        response = connection.get(@path, params)
        ::JSON.parse(response.body)
      end
    end
  end
end
