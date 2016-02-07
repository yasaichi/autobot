require 'delegate'

class Autobot::Resource::Collection < SimpleDelegator
  # Override
  def initialize(klass, method = :new, &block)
    @initialize_with = "#{klass}.#{method}"

    target = ::Enumerator.new do |yielder|
      ::Enumerator.new(&block).each do |attributes|
        yielder << klass.public_send(method, attributes)
      end
    end

    super(target)
  end

  # Override
  def inspect
    "#<#{self.class}:0x#{sprintf("%014x", object_id << 1)}: #{@initialize_with}>"
  end
end
