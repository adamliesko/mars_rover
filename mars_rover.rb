require 'clamp'
require File.expand_path('../lib/plateau', __FILE__)
require File.expand_path('../lib/rover', __FILE__)

class MarsRoverCommand < Clamp::Command
  option '--file_name', 'PATH_TO_FILE', 'path to input file for rovers and plateau definitions (prioritized)', attribute_name: :file_name
  option '--direct_input', 'INPUT_STRING', 'input for rovers and plateau definitions', attribute_name: :direct_input

  def execute
    input = File.read(file_name) if file_name
    input ||= direct_input

    if input
      plateau = Plateau.new input
      plateau.move_rovers

      puts(plateau)
    else
      puts '[Argument Error] Please enter input instructions for Matt.'
    end
  end
end

MarsRoverCommand.run
