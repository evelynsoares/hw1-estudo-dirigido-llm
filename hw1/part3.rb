# Part 3: anagrams

# combine_anagrams(words)
# duas palavras são anagramas se, ordenando as letras o
# resultado for igual: "cars".downcase.chars.sort == "racs".downcase.chars.sort
# agrupar -> group_by { assinatura } devolve Hash { assinatura => [palavras] },
# assinatura usa downcase só pra agrupar; a palavra original
# é o que entra no array de saída

def combine_anagrams(words)
  words.group_by { |word| word.downcase.chars.sort.join }.values
end

# testes
def check(desc, expected, actual)
  if expected == actual
    puts "OK     #{desc}"
  else
    puts "FALHOU #{desc} (esperado #{expected.inspect}, obtido #{actual.inspect})"
  end
end

# ordem dos grupos e das anagramas dentro do grupo nao importa, entao
# ordenamos tudo antes de comparar
input = ['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream']
expected = [["cars", "racs", "scar"], ["four"], ["for"], ["potatoes"], ["creams", "scream"]]
check("exemplo do enunciado",
      expected.map(&:sort).sort, combine_anagrams(input).map(&:sort).sort)

check("case ignorado ao agrupar, preservado na saida",
      ["Rats", "Star", "tars"].sort, combine_anagrams(["Rats", "Star", "tars"]).first.sort)

check("palavra sem anagrama forma grupo proprio",
      [["hello"]], combine_anagrams(["hello"]))

check("lista vazia",
      [], combine_anagrams([]))
