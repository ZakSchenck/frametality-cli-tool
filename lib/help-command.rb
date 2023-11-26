require_relative 'token-parser'

# Class and methods for documentation 
class HelpCommand
    def initialize(user_input)
      @parser = UserInputParser.new(user_input)
    end
  
    def print_help
      if @parser.user_input == "--help"
        print("helped")
      end
    end
end