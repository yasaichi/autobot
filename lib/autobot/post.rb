require_relative './resource/base'

module Autobot
  class Post < Resource::Base
    attr_accessor :body, :time, :type
    establish_connection '/api/talk/post/list'

    def conversation?
      type == 4
    end

    def to_conversation
      question = body.first['comment']['text']
      answers = body[1..-1].map { |reply| reply['text'] }

      [question, answers.join]
    end
  end
end
