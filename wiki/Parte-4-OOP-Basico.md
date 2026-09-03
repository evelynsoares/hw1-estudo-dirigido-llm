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

## Estruturas Ruby usadas

- `attr_accessor` — geração automática de getter/setter.
- Herança de classe (`class JellyBean < Dessert`) e `super` — reuso de
  `initialize` do pai sem duplicar código.
- *Method overriding* (`delicious?` redefinido na subclasse).
