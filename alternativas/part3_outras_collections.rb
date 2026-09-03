# Alternativa a Parte 3: mesma logica de anagramas, trocando a Collection
# usada pra agrupar.
#
# Original (hw1/part3.rb) usa Hash via group_by (a assinatura ordenada vira
# chave do Hash, e o Hash resolve o agrupamento sozinho).
#
# Aqui mostro duas alternativas:
#   1. com Array puro (sem Hash): pra cada palavra, procuro um grupo
#      existente cuja assinatura bata; senao, crio um grupo novo. Precisa de
#      busca linear a cada palavra (O(n) por palavra, O(n^2) no total).
#   2. com Set (biblioteca padrao 'set'): mesma ideia do Hash, mas usando
#      Set só pra mostrar que dava pra usar (na pratica, Set nao ajuda aqui
#      porque nao existe "get by key" em Set como existe em Hash -- serve
#      melhor pra checar pertencimento/unicidade, nao pra agrupar).

def combine_anagrams_array(words)
  groups = []
  words.each do |word|
    signature = word.downcase.chars.sort.join
    existing_group = groups.find { |group| group.first.downcase.chars.sort.join == signature }
    if existing_group
      existing_group << word
    else
      groups << [word]
    end
  end
  groups
end

require 'set'

def combine_anagrams_set(words)
  signatures_seen = Set.new
  groups_by_signature = {}

  words.each do |word|
    signature = word.downcase.chars.sort.join
    signatures_seen << signature # Set so garante "ja vi essa assinatura?"
    groups_by_signature[signature] ||= []
    groups_by_signature[signature] << word
  end

  groups_by_signature.values
end

# ---------------------------------------------------------------------------
# comparacao: Hash (original) x Array x Set
# ---------------------------------------------------------------------------
#
# Hash (original, group_by):
#   + O(n): cada palavra e inserida em O(1) amortizado pela chave (assinatura)
#   + codigo de uma linha, Ruby ja resolve o agrupamento
#   - "esconde" o mecanismo de agrupamento dentro do group_by (bom pra
#     produtividade, ruim se o objetivo e ensinar como agrupar na mao)
#
# Array puro:
#   + nao depende de hashing, so de == e comparacoes -- mais facil de
#     entender pra quem nao viu Hash ainda
#   - O(n^2): pra cada palavra, procura linear em todos os grupos ja criados
#   - mais codigo, mais estado pra rastrear (existing_group)
#
# Set:
#   + otimo pra perguntas de "ja vi isso?" / unicidade (aqui usado so de
#     forma ilustrativa, signatures_seen nao e nem necessario pro resultado)
#   - nao serve pra AGRUPAR sozinho (nao tem "valor associado" como Hash) --
#     no fim das contas ainda precisei de um Hash (groups_by_signature) pra
#     guardar as listas; Set nao substitui Hash nesse problema

def check(desc, expected, actual)
  if expected == actual
    puts "OK     #{desc}"
  else
    puts "FALHOU #{desc} (esperado #{expected.inspect}, obtido #{actual.inspect})"
  end
end

input = ['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream']
expected = [["cars", "racs", "scar"], ["four"], ["for"], ["potatoes"], ["creams", "scream"]]

check("Array: exemplo do enunciado",
      expected.map(&:sort).sort, combine_anagrams_array(input).map(&:sort).sort)

check("Set: exemplo do enunciado",
      expected.map(&:sort).sort, combine_anagrams_set(input).map(&:sort).sort)
