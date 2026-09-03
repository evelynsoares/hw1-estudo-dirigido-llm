# Part 5: advanced OOP, metaprogramming, open classes, duck typing

# attr_accessor_with_history(attr_name), além de getter/setter, guarda
# um Array com TODOS os valores que o atributo já teve
# toda classe é, ela mesma, instância de Class -> definindo o
# método DENTRO de Class ele vira disponível pra qualquer
# classe futura, class_eval com string interpolada -> avalia o texto
# inicializa @bar_history = [nil] na 1a atribuição, e seta @bar
# getter do histórico é sobrescrito -> devolve []
# cada instância tem sua própria @bar_history -> nunca compartilha entre instâncias

class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s # make sure it's a string
    attr_reader attr_name      # create the attribute's getter
    attr_reader attr_name + "_history" # create bar_history getter (sobrescrito abaixo)

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

class Foo
  attr_accessor_with_history :bar
end

# testes
def check(desc, expected, actual)
  if expected == actual
    puts "OK     #{desc}"
  else
    puts "FALHOU #{desc} (esperado #{expected.inspect}, obtido #{actual.inspect})"
  end
end

f = Foo.new
check("historico comeca vazio antes de qualquer atribuicao", [], f.bar_history)

f.bar = 3
f.bar = :wowzo
f.bar = 'boo!'
check("historico do exemplo do enunciado",
      [nil, 3, :wowzo, 'boo!'], f.bar_history)

f2 = Foo.new
f2.bar = 42
check("getter devolve valor atual", 42, f2.bar)

fa = Foo.new
fa.bar = 1
fa.bar = 2
fb = Foo.new
fb.bar = 4
check("historico separado por instancia (fb)", [nil, 4], fb.bar_history)
check("historico separado por instancia (fa)", [nil, 1, 2], fa.bar_history)

other_class = Class.new do
  attr_accessor_with_history :foo
  attr_accessor_with_history :bar
end
obj = other_class.new
obj.foo = 'x'
obj.bar = 'y'
check("funciona com multiplos atributos na mesma classe (foo)", [nil, 'x'], obj.foo_history)
check("funciona com multiplos atributos na mesma classe (bar)", [nil, 'y'], obj.bar_history)
