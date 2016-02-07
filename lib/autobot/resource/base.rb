class Autobot::Resource::Base
  extend Autobot::Resource::QueryMethods
  include Autobot::Concerns::InitializableWithAttributeValues

  attr_accessor :id

  unless respond_to?(:class_name)
    def self.class_name
      name.split('::').last
    end
  end

  def self.from_json(json)
    attributes = json.map do |key, value|
      key_without_prefix = key.sub(/\A#{class_name.downcase}/, '')
      [key_without_prefix.underscore, value]
    end

    new(attributes)
  end
end
