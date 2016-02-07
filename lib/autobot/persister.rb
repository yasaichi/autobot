require 'csv'
require 'fileutils'
require_relative './concerns/initializable_with_attribute_values'

module Autobot
  class Persister
    include Concerns::InitializableWithAttributeValues

    attr_accessor :target_key, :source_keys

    def persist
      file_path = ::Autobot.conversation_data_path(target_key)
      ::FileUtils.mkdir_p(file_path.dirname)

      ::CSV.open(file_path, 'w', col_sep: "\t") do |file|
        file << %w(question answer)

        enum_fetch do |post|
          next unless post.conversation?
          file << post.to_conversation
        end
      end
    end

    private

    def enum_fetch
      return unless block_given?

      source_keys.each do |source_key|
        Post.where(talk_id: source_key).each do |post|
          yield(post)
        end
      end
    end
  end
end
