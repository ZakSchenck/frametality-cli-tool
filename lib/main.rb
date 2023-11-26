require 'json'
require 'colorize'
require_relative 'token-parser'
require_relative 'help-command'
require_relative 'character-data'

print "Welcome to".green
print"
.------..------..------..------..------..------..------..------..------..------..------.
|F.--. ||R.--. ||A.--. ||M.--. ||E.--. ||T.--. ||A.--. ||L.--. ||I.--. ||T.--. ||Y.--. |
| :(): || :(): || (  ) || (  ) || (  ) || :/ : || (  ) || :/ : || (  ) || :/ : || (  ) |
| ()() || ()() || :  : || :  : || :  : || (__) || :  : || (__) || :  : || (__) || :  : |
| '--'F|| '--'R|| '--'A|| '--'M|| '--'E|| '--'T|| '--'A|| '--'L|| '--'I|| '--'T|| '--'Y|
`------'`------'`------'`------'`------'`------'`------'`------'`------'`------'`------'\n".green
print"By Zak Schenck \n".blue
print "Enter your desired frame data. If you need documentation, visit my Github\n".blue


while (user_input = gets.chomp) != 'exit'
  # Get the directory of the current script
  script_directory = File.dirname(__FILE__)
  # absolute path to the JSON file
  json_file_path = File.join(script_directory, '../framedata.json')
  user_input_parser = UserInputParser.new(user_input)
  # Array destructuring each token variable
  character_token, button_token, button_type_token = user_input_parser.parse

  is_valid_token = false

  frame_data_loader = FrameDataLoader.new(json_file_path)
  frame_data = frame_data_loader.load

  help_command = HelpCommand.new(user_input)
  help_command.print_help

  character_data = GenerateCharacterFrameData.new(user_input, frame_data, is_valid_token)
  character_data.validate_character
  character_data.display_single_char_data
  character_data.display_characters_list
  is_valid_token = character_data.validate_character

  output_formatter = OutputFormatter.new([character_token, button_token, button_type_token], frame_data, json_file_path, is_valid_token)
  message_output = output_formatter.generate_message
  
  puts message_output
end
