class Game
  attr_reader :profit, :loss, :winnings, :initial_bet

  def initialize
    @history = []
    @loss = 0
    @winnings = 0
    @initial_bet = 1
    @turn = 0
    @profit = 0
  end

  def roll
    num = rand(36)
    num > 18 ? (@history << "red") : (@history << "black")
  end

  def update_loss
    @loss += @initial_bet
  end

  def update_winnings
    @winnings += (@initial_bet * 2) if @history.last == "red"
  end

  def print_game_outcome
    p "after #{@turn} turns you won $#{@winnings} and you loss $#{@loss}"
    p "Overall profit: $#{@profit}"
  end

  def print_roll_outcome
    p "turn: #{@turn} bet: #{@initial_bet} | winnings: #{@winnings} | lost: #{@loss}" 
  end

  def run(amount)
    while true do
      roll
      update_loss
      update_winnings
      print_roll_outcome if amount < initial_bet
      @initial_bet *= 2
      @turn += 1
      @profit = @winnings - @loss
      break if @history.last == "red"
    end
    # print_game_outcome
  end
end

class Strategy
  attr_reader :bank

  def initialize(starting_cash)
    @bank = starting_cash
    @games_played = 0
    @loss = 0
  end


  def run(times, amount)
    while @games_played <= times do
      game = Game.new
      game.run(amount)
      @bank -= game.loss
      @bank += game.winnings
      @games_played += 1
    end
  end
end


starting_cash = 1000
strat = Strategy.new(starting_cash)
strat.run(10, 10)
p "starting with #{starting_cash} you made #{strat.bank - starting_cash}"