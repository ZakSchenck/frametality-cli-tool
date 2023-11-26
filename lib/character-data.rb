require_relative 'token-parser'
require 'json'

class GenerateCharacterFrameData
    @@character = ""

    def initialize(user_input, frame_data, is_valid_token)
        @parser = UserInputParser.new(user_input)
        @frame_data = frame_data
        @is_valid_token = is_valid_token
    end

    # Validates if character key exists. 
    def validate_character
        if @frame_data.key?(@parser.user_input)
            @@character = @parser.user_input
            return true
        else
            return false
        end
    end

    def move_type_documentation
        puts "--------------------------------------------------------------------------------------------------"
        puts "Frame data for #{@parser.user_input[0].upcase}#{@parser.user_input[1..-1]}. ".green
        puts "Documentation:".blue
        puts "  ob: On Block".blue
        puts "  ob: On Hit".blue
        puts "  ob: On Flawless Block".blue
        puts "  ob: Start Up".blue
        puts "--------------------------------------------------------------------------------------------------"
    end

    # Displays all frame data for a single character
    def display_single_char_data
        if @frame_data.key?(@parser.user_input) 
            move_type_documentation()
            @frame_data[@@character].each do |moves, move|
                puts moves.green
                move.each do |key, val|
                    puts "#{key}: #{val}"
                end
            end
        end
    end

    # Displays all characters available for frame data
    def display_characters_list
        if @parser.user_input == 'characters --list'
            move_type_documentation()
            @frame_data.each do |characterName, charData|
                puts "---------------------------------"
                puts characterName.green
            end
            return true
        else 
            return false
        end
    end
end