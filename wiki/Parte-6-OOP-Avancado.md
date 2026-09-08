# Parte 6 — advanced OOP, metaprogramming, open classes e duck typing (continuação)

[← Home](Home)

## Enunciado (resumo)

(a) Conversão de moeda via `method_missing`: `5.dollars.in(:euros)`,
`10.euros.in(:rupees)`, suportando `dollars`, `euros`, `rupees`, `yen`, no
singular ou plural.

(b) Adaptar `palindrome?` pra virar método de `String` (`"foo".palindrome?`).

(c) Adaptar `palindrome?` pra funcionar em qualquer `Enumerable`
(`[1,2,3,2,1].palindrome?`), sem quebrar em `Hash`.

## Solução

```ruby
class Numeric
  @@currencies = { 'dollar' => 1.0, 'euro' => 1.292, 'rupee' => 0.019, 'yen' => 0.013 }

  def method_missing(method_id, *args)
    singular_currency = method_id.to_s.gsub(/s$/, '')
    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency]
    else
      super
    end
  end

  def respond_to_missing?(method_id, include_private = false)
    @@currencies.has_key?(method_id.to_s.gsub(/s$/, '')) || super
  end

  def in(currency)
    singular_currency = currency.to_s.gsub(/s$/, '')
    self / @@currencies.fetch(singular_currency)
  end
end

class String
  def palindrome?
    cleaned = downcase.gsub(/\W/, '')
    cleaned == cleaned.reverse
  end
end

module Enumerable
  def palindrome?
    to_a == to_a.reverse
  end
end
```

## Explicação do algoritmo

**(a) conversão de moeda**: `method_missing` é chamado automaticamente pelo
Ruby sempre que um método não encontrado é invocado (`5.dollars` não existe
de verdade em `Numeric`). A implementação tira o `"s"` final com
`gsub(/s$/, '')` pra aceitar singular e plural com a mesma chave
(`"dollars"` e `"dollar"` viram `"dollar"`). Se a palavra resultante for uma
moeda conhecida, o número é convertido pra **dólares** (moeda-base da
tabela) multiplicando pela taxa — por isso `5.dollars.in(:euros)` funciona
em dois passos: `5.dollars` devolve "5 em dólares" primeiro, e só depois
`.in(:euros)` converte esse resultado pra euros dividindo pela taxa (o
caminho inverso de "pra dólares"). Se a moeda não é conhecida, `super` deixa
o `NoMethodError` normal acontecer — importante pra não "engolir" erros de
métodos que realmente não existem. `respond_to_missing?` acompanha
`method_missing` por boa prática (`respond_to?` e introspecção continuam
corretos pra essas moedas "fantasma").

**(b) `"foo".palindrome?`**: mesma lógica da Parte 1, só que reaberta dentro
de `String` — como o método passa a viver dentro da própria classe, `self`
já é a string, então não precisa mais receber parâmetro.

**(c) `[1,2,3,2,1].palindrome?`**: qualquer `Enumerable` (Array, Range
etc.) é "palíndromo" se a coleção, convertida em Array (`to_a`), for igual
ao seu `reverse`. Não compara os elementos entre si como palíndromos
individuais, só a ordem da coleção como um todo. Funciona sem erro em
`Hash` também (que é `Enumerable`), porque `Hash#to_a` vira um array de
pares `[chave, valor]` — raramente será igual ao seu reverse, mas nunca
lança exceção.

## Como usei o Claude Code para entender Ruby

Eu pedi ao Claude Code para explicar esta parte comparando mecanismos que não
aparecem juntos com tanta frequência em Python ou C++:

- `method_missing` intercepta uma chamada que não foi definida. Assim,
  `5.dollars` pode ser interpretado a partir do nome do método. Em Python, a
  ideia mais próxima envolve `__getattr__`; em C++, seria necessário outro
  mecanismo, porque chamadas arbitrárias não são normalmente resolvidas assim.
- `respond_to_missing?` foi estudado junto com `method_missing`, porque uma
  classe que responde dinamicamente também deve informar corretamente
  `respond_to?`.
- `module Enumerable` funciona como um *mixin*. Em vez de copiar
  `palindrome?` para `Array`, `Range` e `Hash`, o método é disponibilizado às
  classes que incluem o módulo. Comparei isso com classes auxiliares em C++ e
  com um método comum que recebe a coleção em Python.

Também pedi a diferença entre `to_a == to_a.reverse` e uma iteração manual com
`yield`. O primeiro usa operações prontas; o segundo torna visível o protocolo
de iteração. Os testes de `Array`, `Range`, `Hash` e moeda inválida conferiram
o comportamento real e a preservação do `NoMethodError`.

## Estruturas Ruby usadas

- `method_missing` / `respond_to_missing?` — *duck typing* dinâmico,
  interceptando chamadas de método que não existem de verdade.
- Variável de classe (`@@currencies`) compartilhada entre todas as
  instâncias de `Numeric`.
- *Open classes* aplicadas a classes nativas (`Numeric`, `String`) — Ruby
  permite estender comportamento de qualquer classe, inclusive as da
  biblioteca padrão.
- **Mixin** (`module Enumerable`) — ao definir `palindrome?` dentro do
  módulo `Enumerable`, toda classe que já inclui esse módulo (Array, Range,
  Hash, Set...) ganha o método automaticamente.

## Ver também

Comparação de `palindrome?` **com/sem mixin** e **com/sem `yield`
explícito** em [Implementações alternativas](Implementacoes-Alternativas) e
no código-fonte
[`alternativas/part6_yield_sem_mixin.rb`](https://github.com/evelynsoares/hw1-estudo-dirigido-llm/blob/main/alternativas/part6_yield_sem_mixin.rb).
