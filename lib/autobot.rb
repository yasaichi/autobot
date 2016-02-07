require 'active_support'
require 'active_support/core_ext'
require 'pathname'

require 'autobot/persister'
require 'autobot/post'
require 'autobot/predictor'
require 'autobot/sentence'
require 'autobot/version'

module Autobot
  def self.gem_root
    ::Pathname.new(::File.expand_path('../../', __FILE__))
  end

  def self.conversation_data_path(target_key)
    gem_root.join('tmp', "#{target_key}.tsv")
  end

  def self.model_data_path(target_key)
    gem_root.join('tmp', "#{target_key}.json")
  end
end
