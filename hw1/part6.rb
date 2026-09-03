# Part 6: advanced OOP, metaprogramming, open classes and duck typing

# (a) currency conversion: 5.dollars.in(:euros)
# reabro Numeric e method_missing pra interceptar .dollars, .euros, .rupees, .yen que não existem como métodos de verdade
# se for moeda conhecida, converto pra DÓLARES (moeda base)
# multiplicando pela taxa -> chamo .in(:euros) nesse resultado
# se não for moeda conhecida, chamo super
# #in(currency) faz o caminho inverso

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

# (b) "foo".palindrome?
# mesma lógica do Part 1, mas self já é a string

class String
  def palindrome?
    cleaned = downcase.gsub(/\W/, '')
    cleaned == cleaned.reverse
  end
end

# (c) [1,2,3,2,1].palindrome?
# qualquer Enumerable é "palíndromo" se a coleção (to_a) for igual ao seu reverse

module Enumerable
  def palindrome?
    to_a == to_a.reverse
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

def check_in_delta(desc, expected, actual, delta = 0.0001)
  if (expected - actual).abs <= delta
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

check_in_delta("dollars para euros", 5 / 1.292, 5.dollars.in(:euros))
check_in_delta("euros para rupees (plural)", (10 * 1.292) / 0.019, 10.euros.in(:rupees))
check_in_delta("forma singular dollar/rupee", 1 / 0.019, 1.dollar.in(:rupees))
check_in_delta("forma singular rupee/euro", (10 * 0.019) / 1.292, 10.rupees.in(:euro))

check_raise("moeda desconhecida levanta NoMethodError", NoMethodError) { 5.bitcoins }

check("string palindromo verdadeiro", true, "A man, a plan, a canal -- Panama".palindrome?)
check("string palindromo falso", false, "Abracadabra".palindrome?)

check("array palindromo verdadeiro", true, [1, 2, 3, 2, 1].palindrome?)
check("array palindromo falso", false, [1, 2, 3].palindrome?)
check("range de um elemento eh palindromo", true, (1..1).palindrome?)

begin
  { a: 1 }.palindrome?
  puts "OK     hash nao lanca excecao"
rescue => e
  puts "FALHOU hash nao lanca excecao (levantou #{e.class})"
end
