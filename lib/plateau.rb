require 'enumerator'
require File.expand_path('../rover', __FILE__)

class Plateau
  attr_reader :height, :width, :rovers

  def initialize(input)
    @input = input.split
    @rovers = []
    @height = @input.shift.to_i
    @width = @input.shift.to_i

    initialize_rovers
  end

  def move_rovers
    @rovers.each(&:move)
  end

  def within_bounds?(pos_x, pos_y)
    pos_x.between?(0, @width) && pos_y.between?(0, @height)
  end

  def to_s
    @rovers.each(&:to_s).join("\n")
  end

  private

  def initialize_rovers
    @input.each_slice(4) do |pos_x, pos_y, direction, commands|
      @rovers << Rover.new(pos_x, pos_y, direction, commands.split(''), self)
    end
  end
end
