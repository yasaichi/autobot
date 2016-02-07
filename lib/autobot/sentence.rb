require 'natto'
require_relative './morpheme'

module Autobot
  class Sentence
    DIC_DIR = File.join(`echo $(mecab-config --dicdir)`.chomp, 'mecab-ipadic-neologd').freeze

    def self.mecab
      @mecab ||= ::Natto::MeCab.new(dicdir: DIC_DIR)
    end

    def initialize(sentence)
      @sentence = sentence
    end

    def morphemes
      @morphemes ||= self.class.mecab.enum_parse(@sentence).map do |token|
        features = token.feature.split(',')

        Morpheme.new(
          pos: features[0..2],
          base: features[6],
          surface: token.surface
        )
      end
    end
  end
end
