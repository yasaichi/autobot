require 'autobot'
require 'thor'

module Autobot
  class CLI < ::Thor
    DEFAULT_TARGET_KEY = 'nanamin'.freeze
    DEFAULT_SOURCE_KEYS = %w(
      oc5BnIYL5wZ9GtN76wEuUm==
      Ph9T-_qG1MV9GtN76wEuUm==
    ).freeze

    package_name 'Autobot'
    class_option :'target-key', type: :string, default: DEFAULT_TARGET_KEY

    desc 'setup', 'Setup Autobot'
    option :'source-keys', type: :array, default: DEFAULT_SOURCE_KEYS

    def setup
      attributes = options
        .slice(:'target-key', :'source-keys')
        .transform_keys { |key| key.to_s.tr('-', '_') }

      Persister.new(attributes).persist
      Predictor.new(attributes[:target_key]).train
    end

    desc 'start', 'Start conversation with Autobot'

    def start
      target_key = options[:'target-key']
      predictor = Predictor.new(target_key)

      while !print('> ') && question = $stdin.gets
        best_answer = predictor.predict_answer_to(question)
        puts "#{target_key}：#{best_answer}" if best_answer
      end
    end
  end
end
