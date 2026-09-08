# Parte 2 — Rock-Paper-Scissors

[← Home](Home)

## Enunciado (resumo)

(a) `rps_game_winner(game)`: recebe `[[nome1, jogada1], [nome2, jogada2]]` e
devolve o par vencedor. Levanta `WrongNumberOfPlayersError` se não forem 2
jogadores, e `NoSuchStrategyError` se alguma jogada não for R/P/S
(case-insensitive). Empate → primeiro jogador vence.

(b) `rps_tournament_winner(tournament)`: torneio codificado como array
aninhado de profundidade arbitrária (2ⁿ jogadores); resolve recursivamente
até sobrar um único vencedor.

## Solução

```ruby
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

def leaf_game?(node)
  node.length == 2 && node.all? { |player| player.is_a?(Array) && player[1].is_a?(String) }
end

def rps_tournament_winner(tournament)
  return rps_game_winner(tournament) if leaf_game?(tournament)

  winners = tournament.map { |sub_tournament| rps_tournament_winner(sub_tournament) }
  rps_tournament_winner(winners)
end
```

## Explicação do algoritmo

**`rps_game_winner`**: `WINS_AGAINST` é um `Hash` que mapeia cada jogada
pra aquela que ela vence (`'R' => 'S'` = Rock vence Scissors). Em vez de um
`if/elsif` gigante checando as 9 combinações possíveis de R/P/S, basta
checar se `WINS_AGAINST[jogada1] == jogada2` — se bater, jogador 1 venceu.
Empate (`strategy1 == strategy2`) é tratado explicitamente antes, porque
nesse caso nenhuma jogada "vence" a outra no hash.

**`rps_tournament_winner`**: a estrutura de dados é recursiva por natureza
(um torneio é ou um jogo, ou uma lista de sub-torneios), então a solução
também é recursiva. `leaf_game?` decide se estamos numa folha (jogo real,
`[[nome,jogada],[nome,jogada]]`) ou num galho (lista de sub-torneios que
ainda precisam ser resolvidos) checando o formato dos elementos. Se for
folha, resolve direto com `rps_game_winner`. Se não for, resolve cada
sub-torneio recursivamente (`map`), pega a lista de vencedores, e chama a
si mesma de novo nessa lista até sobrar um único vencedor — isso cobre
profundidade arbitrária sem precisar saber de antemão quantos "rounds"
existem.

## Como usei o Claude Code para entender Ruby

Nesta parte, a dificuldade foi perceber que Ruby trata arrays aninhados,
blocos e exceções de uma forma mais compacta do que Python e C++. Eu pedi ao
Claude Code para reescrever cada trecho em uma forma mais explícita e fazer a
tradução conceitual:

- `player1, player2 = game` é *destructuring assignment*. Em Python há uma
  ideia equivalente; em C++ normalmente seria necessário acessar posições do
  vetor ou usar uma estrutura própria.
- `game.map { |sub_tournament| ... }` combina iteração e transformação. Em
  Python se aproxima de uma list comprehension; em C++ se aproxima de
  `std::transform`, mas Ruby passa o bloco diretamente ao método.
- `raise ... unless condicao` é uma forma idiomática de validação. Pedi a
  versão com `if` para entender que `unless` significa "se a condição não for
  verdadeira".
- `class WrongNumberOfPlayersError < StandardError; end` cria uma exceção
  própria por herança. Isso corresponde a criar uma classe de exceção em
  Python ou uma classe derivada de `std::exception` em C++.

Também investiguei por que a recursão termina: `leaf_game?` é o caso-base;
cada chamada resolve subtorneios menores; e a lista de vencedores vira um
novo jogo. Validei a explicação com um torneio de um jogo, um empate e
entradas que levantam as duas exceções.

## Estruturas Ruby usadas

- `Hash` congelado (`.freeze`) como tabela de regras — evita `if/elsif`
  repetitivo e mutação acidental da tabela.
- Hierarquia de exceções customizada (`WrongNumberOfPlayersError < StandardError`).
- Recursão sobre estrutura de dados aninhada (árvore implícita no array),
  com `Enumerable#map` pra resolver "irmãos" no mesmo nível antes de subir
  um nível.
