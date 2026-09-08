# Parte 5 — advanced OOP, metaprogramming, open classes e duck typing

[← Home](Home)

## Enunciado (resumo)

Implementar `attr_accessor_with_history`, que funciona como `attr_accessor`
mas também guarda um array com **todo** valor que o atributo já teve
(incluindo o `nil` inicial, antes de qualquer atribuição), separado por
instância.

## Solução

```ruby
class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s
    attr_reader attr_name
    attr_reader attr_name + "_history"

    class_eval %Q{
      def #{attr_name}=(val)
        @#{attr_name}_history = [nil] if @#{attr_name}_history.nil?
        @#{attr_name}_history << val
        @#{attr_name} = val
      end

      def #{attr_name}_history
        @#{attr_name}_history || []
      end
    }
  end
end
```

## Explicação do algoritmo

Esse é o exercício mais avançado do HW1 e vale destrinchar em partes:

1. **Onde definir o método**: em Ruby, toda classe (`Foo`, `JellyBean`
   etc.) é, ela mesma, uma instância de `Class`. Definindo
   `attr_accessor_with_history` **dentro** de `Class` (reabrindo essa classe
   nativa — *open class*), o método fica disponível como "método de classe"
   pra qualquer classe futura, exatamente como o `attr_accessor` de
   verdade.
2. **Gerar métodos sem saber o nome do atributo antes**: como o nome do
   atributo (`bar`, `foo`, o que for) só é conhecido em tempo de execução,
   não dá pra escrever `def bar=(val)` fixo no código-fonte. A solução é
   `class_eval` com uma string interpolada (`%Q{...}`) — o Ruby avalia esse
   texto como se fosse código escrito dentro da classe que chamou
   `attr_accessor_with_history`, com `#{attr_name}` substituído pelo nome
   real do atributo.
3. **O setter gerado** inicializa `@bar_history = [nil]` na primeira
   atribuição (representando "o valor antes de existir"), dá `push` do novo
   valor, e por fim seta `@bar` normalmente — comportamento idêntico a um
   setter comum, só que com o efeito colateral de registrar histórico.
4. **O getter do histórico** é sobrescrito por cima do `attr_reader` simples
   pra nunca devolver `nil` quando nada foi atribuído ainda — devolve `[]`.
5. **Isolamento por instância**: cada `Foo.new` tem sua própria
   `@bar_history`, porque *instance variables* pertencem ao objeto, não à
   classe — duas instâncias de `Foo` nunca compartilham histórico.

## Como usei o Claude Code para entender Ruby

Esta foi a parte em que mais precisei de explicações graduais. Em Python e
C++, eu normalmente declararia os métodos antes de criar os objetos. Em Ruby,
`attr_accessor_with_history` modifica a própria classe e gera métodos em
tempo de execução. Pedi ao Claude Code para explicar o processo em três
níveis: comparar `attr_accessor` com getters e setters manuais; isolar
`class_eval` e `#{attr_name}`; e comparar a solução com uma versão sem
metaprogramação.

Essa comparação mostrou que `attr_accessor` é um método que recebe um símbolo,
e não uma palavra reservada equivalente a `property`. Também mostrou que a
interpolação monta o nome do método, como `bar=`, antes de o Ruby avaliar o
código dentro da classe. Em Python, a ideia se aproxima de `setattr` ou de um
descritor; em C++, a geração dinâmica de métodos não faz parte do modelo usual
da linguagem.

Os testes de duas instâncias e de dois atributos na mesma classe confirmaram
que o histórico fica em variáveis de instância e não em uma variável
compartilhada pela classe.

## Estruturas Ruby usadas

- *Open classes* (reabrir `Class`) — mecanismo que permite ao Ruby, ao
  contrário da maioria das linguagens, adicionar métodos a classes já
  existentes (inclusive nativas).
- `class_eval` com string interpolada — geração de código em tempo de
  execução (uma forma de *metaprogramming*).
- `attr_reader` — reuso do gerador de getter padrão pro caso simples.
- *Instance variables* dinâmicas (`@#{attr_name}`) — o nome da variável de
  instância também é montado em tempo de execução.

## Ver também

Comparação com a mesma funcionalidade **sem metaprogramming** (getter/setter
escritos na mão, sem `class_eval`) em
[Implementações alternativas](Implementacoes-Alternativas) e no código-fonte
[`alternativas/part5_sem_metaprogramming.rb`](https://github.com/evelynsoares/hw1-estudo-dirigido-llm/blob/main/alternativas/part5_sem_metaprogramming.rb).
