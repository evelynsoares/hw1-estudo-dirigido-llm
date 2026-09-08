class WrongNumberOfPlayersError < StandardError; end
class NoSuchStrategyError < StandardError; end

VALID_STRATEGIES = %w[R P S].freeze

def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2

  player1, player2 = game
  strategy1 = player1[1].to_s.upcase
  strategy2 = player2[1].to_s.upcase

  unless VALID_STRATEGIES.include?(strategy1) && VALID_STRATEGIES.include?(strategy2)
    raise NoSuchStrategyError
  end

  return player1 if strategy1 == strategy2

  player1_wins = case strategy1
                 when 'R' then strategy2 == 'S'
                 when 'P' then strategy2 == 'R'
                 when 'S' then strategy2 == 'P'
                 end

  player1_wins ? player1 : player2
end

def check(description, expected, actual)
  if expected == actual
    puts "OK     #{description}"
  else
    puts "FALHOU #{description}"
  end
end

def check_raise(description, error_class)
  yield
  puts "FALHOU #{description}"
rescue error_class
  puts "OK     #{description}"
end

check('case: scissors beats paper', ['Pam', 'S'],
      rps_game_winner([['Kristen', 'P'], ['Pam', 'S']]))
check('case: tie keeps first player', ['A', 'R'],
      rps_game_winner([['A', 'R'], ['B', 'r']]))
check_raise('case: invalid strategy', NoSuchStrategyError) do
  rps_game_winner([['A', 'X'], ['B', 'R']])
end
