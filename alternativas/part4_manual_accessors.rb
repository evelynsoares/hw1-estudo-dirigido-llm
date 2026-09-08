class Dessert
  def initialize(name, calories)
    @name = name
    @calories = calories
  end

  def name
    @name
  end

  def name=(value)
    @name = value
  end

  def calories
    @calories
  end

  def calories=(value)
    @calories = value
  end

  def healthy?
    @calories < 200
  end

  def delicious?
    true
  end
end

class JellyBean < Dessert
  def initialize(name, calories, flavor)
    super(name, calories)
    @flavor = flavor
  end

  def flavor
    @flavor
  end

  def flavor=(value)
    @flavor = value
  end

  def delicious?
    @flavor != 'black licorice'
  end
end

def check(description, expected, actual)
  if expected == actual
    puts "OK     #{description}"
  else
    puts "FALHOU #{description}"
  end
end

dessert = Dessert.new('Brownie', 250)
check('manual getter name', 'Brownie', dessert.name)
dessert.calories = 150
check('manual setter calories', 150, dessert.calories)
check('manual healthy?', true, dessert.healthy?)

bean = JellyBean.new('Jelly Bean', 50, 'cherry')
check('manual inherited healthy?', true, bean.healthy?)
bean.flavor = 'black licorice'
check('manual override delicious?', false, bean.delicious?)
