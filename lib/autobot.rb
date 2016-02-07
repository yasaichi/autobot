require 'active_support'
require 'active_support/core_ext'
require 'csv'
require 'json'
require 'pathname'

module Autobot
  autoload :Morpheme,  'autobot/morpheme'
  autoload :Persister, 'autobot/persister'
  autoload :Post,      'autobot/post'
  autoload :Predictor, 'autobot/predictor'
  autoload :Sentence,  'autobot/sentence'
  autoload :WordVec,   'autobot/word_vec'

  module Concerns
    autoload :InitializableWithAttributeValues, 'autobot/concerns/initializable_with_attribute_values'
  end

  module Resource
    autoload :Base,         'autobot/resource/base'
    autoload :Collection,   'autobot/resource/collection'
    autoload :Connection,   'autobot/resource/connection'
    autoload :QueryMethods, 'autobot/resource/query_methods'
  end

  def self.gem_root
    Pathname.new(File.expand_path('../../', __FILE__))
  end

  def self.conversation_data_path(target_key)
    gem_root.join('tmp', "#{target_key}.tsv")
  end

  def self.model_data_path(target_key)
    gem_root.join('tmp', "#{target_key}.json")
  end
end
