require 'forwardable'

class Autobot::WordVec
  extend Forwardable

  def_delegator :'@vector', :dup, :to_h
  def_delegators :'@vector', :[], :empty?, :size

  def self.from_words(words:, idf_table:)
    tf_vec = words.reduce(Hash.new(0)) do |hash, word|
      hash.merge!(word => hash[word] + 1.0 / words.size)
    end

    idf_vec = words.uniq.reduce({}) do |hash, word|
      hash.merge!(word => idf_table[word] || idf_table[''])
    end

    vector = idf_vec.reduce(tf_vec) do |hash, (word, idf)|
      hash.merge!(word => hash[word] * idf)
    end

    new(vector)
  end

  def initialize(vector)
    @vector = vector.dup
    @vector.default = 0
  end

  def norm
    @norm ||= Math.sqrt(@vector.values.reduce(0) { |sum, v| sum += v**2 })
  end

  def similarity_to(other)
    numerator = @vector.keys.reduce(0) do |sum, word|
      sum += @vector[word] * other[word].to_f
    end

    numerator / (norm * other.norm)
  end
end
