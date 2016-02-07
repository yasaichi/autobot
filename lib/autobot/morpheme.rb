class Autobot::Morpheme
  include Autobot::Concerns::InitializableWithAttributeValues

  ADJECTIVE = '形容詞'.freeze
  ADJECTIVAL_VERB = '形容動詞'.freeze
  NOUN = '名詞'.freeze
  NUMBER = '数'.freeze
  VERB = '動詞'.freeze
  INFLECTABLE_TYPES = %i(adjective adjectival_verb verb).freeze

  ATTRIBUTES = %i(base pos surface).freeze
  attr_accessor *ATTRIBUTES

  %w(adjective adjectival_verb noun verb).each do |pos_name|
    constant = const_get(pos_name.upcase)
    define_method("#{pos_name}?") { pos.first == constant }
  end

  def ==(other)
    return false unless self.class == other.class
    other.equal?(self) || base == other.base && pos == other.pos
  end
  alias_method :eql?, :==

  def inflectable?
    INFLECTABLE_TYPES.any? { |pos| public_send("#{pos}?") }
  end

  def number?
    pos[1] == NUMBER
  end
end
