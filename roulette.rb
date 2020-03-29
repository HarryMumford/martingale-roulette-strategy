class Game
  attr_reader :profit, :spending, :bank, :initial_bet

  def initialize
    @history = []
    @spending = 0
    @bank = 0
    @initial_bet = 10
    @turn = 0
    @profit = 0
  end

  def roll
    num = rand(36)
    num > 18 ? (@history << "red") : (@history << "black")
  end

  def update_spending
    @spending += @initial_bet
  end

  def update_bank
    @bank += (@initial_bet * 2) if @history.last == "red"
  end

  def print_game_outcome
    p "after #{@turn} turns you won $#{@bank} and you spent $#{@spending}"
    p "Overall profit: $#{@profit}"
  end

  def print_roll_outcome
    p "bet: #{@initial_bet} | bank: #{@bank} | spent: #{@spending}" 
  end

  def run(silent)
    while true do
      roll
      update_spending
      update_bank
      print_roll_outcome unless silent
      @initial_bet *= 2
      @turn += 1
      @profit = @bank - @spending
      break if @history.last == "red"
    end
    print_game_outcome unless silent
  end
end

class Strategy
  attr_reader :bank, :spending

  def initialize
    @bank = 1000
    @games_played = 0
    @spending = 0
  end


  def run(times, amount)
    while @games_played <= times do
      game = Game.new
      game.run(true)
      p "$#{amount} exceeded" if game.initial_bet > amount
      @bank -= game.spending
      @bank += game.bank
      @games_played += 1
    end
  end
end

strat = Strategy.new
strat.run(10000000, 100000000)
p strat.bank