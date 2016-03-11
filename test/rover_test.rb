require 'minitest/autorun'

require File.expand_path('../../lib/plateau', __FILE__)
require File.expand_path('../../lib/rover', __FILE__)

require 'pry'
class RoverTest < Minitest::Test
  def setup
    @plateau = Plateau.new "5 5\n1 2 N LMLMLMLMM 3 3 E MMRMMRMRRM"

    @rover1 = Rover.new(1, 2, 'N', 'LMLMLMLMM'.split(''), @plateau)
    @rover2 = Rover.new(3, 3, 'E', 'MMRMMRMRRM'.split(''), @plateau)
  end

  def test_rover_turns_right
    @rover1.step('R')
    assert_equal 'E', @rover1.direction

    @rover1.step('R')
    assert_equal 'S', @rover1.direction

    @rover1.step('R')
    assert_equal 'W', @rover1.direction

    @rover1.step('R')
    assert_equal 'N', @rover1.direction
  end

  def test_rover_turns_left
    @rover1.step('L')
    assert_equal 'W', @rover1.direction

    @rover1.step('L')
    assert_equal 'S', @rover1.direction

    @rover1.step('L')
    assert_equal 'E', @rover1.direction

    @rover1.step('L')
    assert_equal 'N', @rover1.direction
  end

  def test_rover_moves_forward
    @rover1.step('M')

    assert_equal 'N', @rover1.direction
    assert_equal 3, @rover1.pos_y
    assert_equal 1, @rover1.pos_x

    @rover1.step('M')

    assert_equal 'N', @rover1.direction
    assert_equal 4, @rover1.pos_y
    assert_equal 1, @rover1.pos_x
  end

  def test_rovers_moves_within_the_bounds_of_its_plateau
    origin_pos_x = @rover1.pos_x
    10.times { @rover1.step('M') }

    assert_equal @plateau.height, @rover1.pos_y
    assert_equal origin_pos_x, @rover1.pos_x

    @rover1.step('R')

    10.times { @rover1.step('M') }
    assert_equal @plateau.height, @rover1.pos_y
    assert_equal @plateau.width, @rover1.pos_x
  end

  def test_to_s_returns_its_position_and_direction
    assert_equal '1 2 N', @rover1.to_s
    assert_equal '3 3 E', @rover2.to_s
  end

  def test_rover_moves_to_the_final_position
    @rover1.move
    assert_equal 1, @rover1.pos_x
    assert_equal 3, @rover1.pos_y
    assert_equal 'N', @rover1.direction

    @rover2.move
    assert_equal 5, @rover2.pos_x
    assert_equal 1, @rover2.pos_y
    assert_equal 'E', @rover2.direction
  end
end
