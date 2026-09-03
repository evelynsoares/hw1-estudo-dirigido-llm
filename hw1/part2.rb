# Part 2: Rock-Paper-Scissors

# (a) rps_game_winner(game)
# jogo = [[nome1, jogada1], [nome2, jogada2]]. validar antes: 2 jogadores
# e cada jogada precisa ser R, P ou S
# monto um hash "o que cada jogada vence" e checo se jogada 1 vence a 2
# empate ou vitória -> jogador 1 ganha, senão jogador 2 ganha

class WrongNumberOfPlayersError < StandardError; end
class NoSuchStrategyError < StandardError; end

WINS_AGAINST = { 'R' => 'S', 'P' => 'R', 'S' => 'P' }.freeze

def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2

  player1, player2 = game
  strategy1 = player1[1].to_s.upcase
  strategy2 = player2[1].to_s.upcase

  raise NoSuchStrategyError unless WINS_AGAINST.key?(strategy1) && WINS_AGAINST.key?(strategy2)

  if strategy1 == strategy2 || WINS_AGAINST[strategy1] == strategy2
    player1
  else
    player2
  end
end

# um "jogo" folha é array de 2 elementos, cada um [nome, jogada] (jogada é String)
def leaf_game?(node)
  node.length == 2 && node.all? { |player| player.is_a?(Array) && player[1].is_a?(String) }
end

# (b) rps_tournament_winner(tournament)
# ou é um jogo folha ([nome,jogada] par a par) ou é
# lista de sub-torneios ainda por resolver
# folha = array de 2 elementos onde cada um é [nome_string, jogada_string]
# senão, resolvo cada sub-torneio recursivamente, pego os vencedores e
# jogo eles entre si até sobrar 1

def rps_tournament_winner(tournament)
  return rps_game_winner(tournament) if leaf_game?(tournament)

  winners = tournament.map { |sub_tournament| rps_tournament_winner(sub_tournament) }
  rps_tournament_winner(winners)
end

# testes

def check(desc, expected, actual)
  if expected == actual
    puts "OK     #{desc}"
  else
    puts "FALHOU #{desc} (esperado #{expected.inspect}, obtido #{actual.inspect})"
  end
end

def check_raise(desc, error_class)
  yield
  puts "FALHOU #{desc} (esperava #{error_class}, nao levantou nada)"
rescue error_class
  puts "OK     #{desc}"
rescue => e
  puts "FALHOU #{desc} (levantou #{e.class}, esperava #{error_class})"
end

check_raise("numero errado de jogadores", WrongNumberOfPlayersError) do
  rps_game_winner([["A", "R"]])
end

check_raise("estrategia invalida", NoSuchStrategyError) do
  rps_game_winner([["A", "X"], ["B", "R"]])
end

check("scissors bate paper",
      ["Pam", "S"], rps_game_winner([["Kristen", "P"], ["Pam", "S"]]))

check("empate: primeiro jogador ganha",
      ["A", "R"], rps_game_winner([["A", "R"], ["B", "r"]]))

check("estrategia case-insensitive",
      ["A", "r"], rps_game_winner([["A", "r"], ["B", "s"]]))

tournament = [
  [
    [["Kristen", "P"], ["Dave", "S"]],
    [["Richard", "R"], ["Michael", "S"]],
  ], [
    [["Allen", "S"], ["Omer", "P"]],
    [["David E.", "R"], ["Richard X.", "P"]]
  ]
]
check("torneio aninhado do enunciado",
      ["Richard", "R"], rps_tournament_winner(tournament))

check("torneio com um unico jogo tambem funciona",
      ["A", "R"], rps_tournament_winner([["A", "R"], ["B", "S"]]))
