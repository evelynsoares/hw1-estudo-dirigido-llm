# Part 4: Basic OOP

# (a) Dessert
# getters/setters simples -> attr_accessor
# healthy? -> regra simples: calories < 200. delicious? -> sempre true

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

# (b) JellyBean < Dessert
# herda tudo de Dessert (inclusive healthy?), só precisa guardar/expor
# "flavor" (attr_accessor de novo) e sobrescrever delicious? pro caso
# especial "black licorice"
# super(name, calories) no initialize reaproveita a lógica do pai em vez
# de duplicar "@name = name; @calories = calories"

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

# testes
def check(desc, expected, actual)
  if expected == actual
    puts "OK     #{desc}"
  else
    puts "FALHOU #{desc} (esperado #{expected.inspect}, obtido #{actual.inspect})"
  end
end

dessert = Dessert.new("Brownie", 250)
check("getter name", "Brownie", dessert.name)
check("getter calories", 250, dessert.calories)
dessert.calories = 100
check("setter calories", 100, dessert.calories)

check("dessert com menos de 200 calorias eh healthy",
      true, Dessert.new("Fruit salad", 150).healthy?)
check("dessert com 200+ calorias nao eh healthy",
      false, Dessert.new("Cake", 400).healthy?)
check("dessert generico sempre delicious",
      true, Dessert.new("Anything", 999).delicious?)

bean = JellyBean.new("JB", 50, "cherry")
check("jelly bean herda healthy?", true, bean.healthy?)
check("jelly bean sabor comum eh delicious", true, bean.delicious?)

licorice_bean = JellyBean.new("JB", 50, "black licorice")
check("jelly bean black licorice nao eh delicious", false, licorice_bean.delicious?)

bean.flavor = "grape"
check("setter de flavor", "grape", bean.flavor)
