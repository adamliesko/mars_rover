class Rover
  attr_accessor :pos_x, :pos_y, :direction

  COMMANDS_TO_ACTIONS = { 'L' => :turn_left, 'R' => :turn_right, 'M' => :move_forward }
  DIRECTIONS = %w(N E S W)

  def initialize(pos_x = 0, pos_y = 0, direction = 'N', commands, plateau)
    @pos_x = pos_x.to_i
    @pos_y = pos_y.to_i
    @direction = direction

    @commands = commands
    @plateau = plateau
  end

  def step(command)
    action = COMMANDS_TO_ACTIONS[command]
    send(action) if action
  end

  def to_s
    "#{@pos_x} #{@pos_y} #{direction}"
  end

  def move
    while (action = @commands.shift)
      step(action)
    end
  end

  private

  def move_forward
    move_x, move_y = case @direction
                     when 'N'
                       [0, 1]
                     when 'E'
                       [+1, 0]
                     when 'S'
                       [0, -1]
                     when 'W'
                       [-1, 0]
                     else
                       return
                     end

    new_pos_x = @pos_x + move_x
    new_pos_y = @pos_y + move_y

    if @plateau.within_bounds?(new_pos_x, new_pos_y)
      @pos_x = new_pos_x
      @pos_y = new_pos_y
    end
  end

  def turn_right
    current_direction_idx = DIRECTIONS.index(@direction)
    possible_direction_idx = current_direction_idx + 1
    @direction = possible_direction_idx >= 4 ? DIRECTIONS[0] : DIRECTIONS[possible_direction_idx]
  end

  def turn_left
    current_direction_idx = DIRECTIONS.index(@direction)
    possible_direction_idx = current_direction_idx - 1
    @direction = possible_direction_idx < 0 ? DIRECTIONS[3] : DIRECTIONS[possible_direction_idx]
  end
end
