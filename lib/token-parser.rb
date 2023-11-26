require 'json'

# Class for getting user input and parses each separate token.
class UserInputParser
    attr_reader :user_input

    def initialize(user_input)
      @user_input = user_input
    end

    # Getter for user input
    def get_user_input
        @user_input
    end
  
    # Array destructuring for each token. Switches each token to lowercase
    def parse
      tokens = @user_input.split('-').map(&:downcase)
      character_token, button_token, button_type_token = tokens
      [character_token, button_token, button_type_token]
    end
end
  
  # Class for loading and reading the frame data file
class FrameDataLoader
    def initialize(json_file_path)
      @json_file_path = json_file_path
    end
  
    def load
      JSON.parse(File.read(@json_file_path))
    end
end
  
  # Class for handling the command line output based on user input
class OutputFormatter
    attr_reader :is_valid_input

    def initialize(tokens, frame_data, json_file_path, is_valid_token)
      @character_token, @button_token, @button_type_token = tokens
      @frame_data = frame_data
      @json_file_path = json_file_path
      @is_valid_input = true
      @is_valid_token = is_valid_token
    end
  
    # Logic for generating the output message
    def generate_message
        if ((@character_token.nil? || @button_token.nil? || @button_type_token.nil?) && !@is_valid_token)
          # Print an error message for invalid input format
          puts "--------------------------------------------------------------------------------------------------"
          puts "Invalid input format. For documentation, visit my Github or type '--help'".red
          puts "--------------------------------------------------------------------------------------------------"
        elsif @frame_data[@character_token] &&
              @frame_data[@character_token][@button_token] &&
              @frame_data[@character_token][@button_token][@button_type_token]
          @is_valid_token = true
          # If tests pass, throw the user a message with the data
          puts "--------------------------------------------------------------------------------------------------"
          string_type = calculate_string_type
          puts "#{@character_token[0].upcase + @character_token[1..-1]}'s #{@button_token} is #{@frame_data[@character_token][@button_token][@button_type_token]} frames #{@string_type}".red
          puts "--------------------------------------------------------------------------------------------------"
        end
      end
    private
  
    # Sets the string type variable to a certain word pattern based on the user's input
    def calculate_string_type
      case @button_type_token
      when 'ob'
      @string_type = 'of advantage on block.'
      when 'oh'
      @string_type = 'of advantage on hit.'
      when 'ofb'
      @string_type = 'of advantage on flawless block.'
      else
      @string_type = 'of start up'
      end
   end
end