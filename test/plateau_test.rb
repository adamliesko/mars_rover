require 'minitest/autorun'

require File.expand_path('../../lib/plateau', __FILE__)
require File.expand_path('../../lib/rover', __FILE__)

class PlateauTest < Minitest::Test
  def setup
    @plateau = Plateau.new "5 5\n1 2 N LMLMLMLMM 3 3 E MMRMMRMRRM"
  end

  def test_initializes_with_given_plateau_sizes
    assert_equal 5, @plateau.width
    assert_equal 5, @plateau.height
  end

  def test_moving_rovers_to_their_final_position
    @plateau.move_rovers
    rovers = @plateau.rovers

    assert_equal 1, rovers[0].pos_x
    assert_equal 3, rovers[0].pos_y
    assert_equal 'N', rovers[0].direction
    assert_equal 5, rovers[1].pos_x
    assert_equal 1, rovers[1].pos_y
    assert_equal 'E', rovers[1].direction
  end

  def test_to_s_summary_output
    assert_equal "1 2 N\n3 3 E", @plateau.to_s
    @plateau.move_rovers
    assert_equal "1 3 N\n5 1 E", @plateau.to_s
  end

  def test_within_bounds_returns_bool
    refute @plateau.within_bounds?(10, 10)
    refute @plateau.within_bounds?(-1, -1)
    assert @plateau.within_bounds?(1, 1)
  end
end
