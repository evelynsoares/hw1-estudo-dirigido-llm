# Parte 4 — Basic OOP

[← Home](Home)

## Enunciado (resumo)

(a) Classe `Dessert` com getters/setters de `name`/`calories`;
`healthy?` (true se `calories < 200`) e `delicious?` (sempre true).

(b) Classe `JellyBean < Dessert`, com getter/setter de `flavor`;
`delicious?` sobrescrito pra devolver `false` só quando o sabor é
`"black licorice"`.

## Solução

```ruby
class Dessert
  attr_accessor :name, :calories

  def initialize(name, calories)
    @name = name
    @calories = calories
  end

  def healthy?
    calories < 200
  end

  def delicious?
    true
  end
end

class JellyBean < Dessert
  attr_accessor :flavor

  def initialize(name, calories, flavor)
    super(name, calories)
    @flavor = flavor
  end

  def delicious?
    flavor != 'black licorice'
  end
end
```

## Explicação do algoritmo

Não há algoritmo complexo aqui — o exercício é sobre modelagem OOP básica.
`attr_accessor :name, :calories` gera automaticamente os métodos `name`,
`name=`, `calories` e `calories=` (economiza escrever 4 métodos na mão).
`healthy?` é regra de negócio direta (`calories < 200`).

O ponto central é a **herança**: `JellyBean < Dessert` reaproveita
`initialize` do pai via `super(name, calories)` — em vez de duplicar
`@name = name; @calories = calories`, delega essa parte pro construtor da
superclasse e só cuida do que é específico de `JellyBean` (`@flavor`).
`healthy?` nem precisa ser reescrito: `JellyBean` herda o comportamento de
`Dessert` automaticamente. Só `delicious?` é sobrescrito (*override*), pra
adicionar a regra especial do sabor licorice preta — e essa sobrescrita
não quebra o contrato: continua devolvendo `true` pra todos os outros casos
(inclusive `Dessert` puro, que nem conhece o conceito de sabor).

## Como usei o Claude Code para entender Ruby

Eu pedi ao Claude Code para comparar a classe Ruby com uma implementação
equivalente em Python e C++, porque a sintaxe de atributos e construtores é
bem diferente:

- `attr_accessor :name, :calories` gera métodos de leitura e escrita. Em
  Python, a ideia se aproxima de uma `property`; em C++, seria necessário
  declarar os atributos e escrever getters e setters.
- `@name` e `@calories` são variáveis de instância. Sem o `@`, `name` dentro
  de um método significa chamada de método, não acesso direto ao campo.
- `class JellyBean < Dessert` expressa herança diretamente no cabeçalho. A
  subclasse usa `super(name, calories)` para chamar o construtor da classe
  pai; pedi exemplos com e sem `super` para observar a duplicação causada pela
  alternativa manual.
- O ponto de interrogação em `healthy?` e `delicious?` faz parte do nome do
  método e segue a convenção Ruby para métodos que retornam booleano.

Depois da explicação, alterei atributos nos testes e comparei o comportamento
de `Dessert` com o de `JellyBean`. Isso confirmou a herança de `healthy?` e a
sobrescrita de `delicious?`.

## Estruturas Ruby usadas

- `attr_accessor` — geração automática de getter/setter.
- Herança de classe (`class JellyBean < Dessert`) e `super` — reuso de
  `initialize` do pai sem duplicar código.
- *Method overriding* (`delicious?` redefinido na subclasse).

## Ver também

Comparação entre `attr_accessor` e getters/setters manuais em
[Implementações alternativas](Implementacoes-Alternativas) e no código-fonte
[`alternativas/part4_manual_accessors.rb`](https://github.com/evelynsoares/hw1-estudo-dirigido-llm/blob/main/alternativas/part4_manual_accessors.rb).
