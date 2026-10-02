# lib/hello_gem.rb
require "hello_gem/version"

module HelloGem
  class Greeter
    GREETINGS = {
      en: "Hello",
      es: "Hola",
      fr: "Bonjour",
      zh: "你好"
    }.freeze

    def initialize(language: :en)
      @language = language
    end

    def greet(name)
      greeting = GREETINGS[@language] || GREETINGS[:en]
      "#{greeting}, #{name}!"
    end
  end

  def self.greet(name, language: :en)
    Greeter.new(language: language).greet(name)
  end
end