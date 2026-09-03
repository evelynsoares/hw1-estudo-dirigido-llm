# Alternativa a Parte 6(c): mesmo palindrome? de Enumerable, mostrando duas
# variações separadas -- (1) sem mixin, (2) com yield explícito.
#
# Original (hw1/part6.rb): `module Enumerable; def palindrome?; to_a == to_a.reverse; end; end`
# -- é mixin (qualquer classe que inclua Enumerable ganha o método de graça)
# e usa métodos prontos (to_a, reverse), sem escrever nenhum `yield`.

# --- (1) sem mixin: método solto, recebe a coleção como argumento --------
#
# Em vez de "morar" dentro de Enumerable (afetando TODAS as classes que
# incluem esse módulo, inclusive as da biblioteca padrão), esse método fica
# isolado -- só afeta quem chama ele explicitamente.
def palindrome_sem_mixin?(collection)
  collection.to_a == collection.to_a.reverse
end

# --- (2) com yield explícito: reconstruo a ordem invertida na mão --------
#
# each_backwards é um iterador customizado (usa yield, igual o Array#each
# faz por baixo dos panos) que percorre um array de tras pra frente sem
# chamar Array#reverse.
def each_backwards(array)
  i = array.length - 1
  while i >= 0
    yield array[i]
    i -= 1
  end
end

def palindrome_com_yield?(collection)
  elements = collection.to_a

  reversed = []
  each_backwards(elements) { |el| reversed << el }

  elements == reversed
end

# ---------------------------------------------------------------------------
# comparacao: mixin x metodo solto | sem yield explicito x com yield
# ---------------------------------------------------------------------------
#
# Mixin (module Enumerable, original):
#   + uso super natural: [1,2,3].palindrome? -- parece metodo nativo do Ruby
#   + zero mudanca nos call sites, todo Enumerable ja "ganha" o metodo
#   - open class em modulo da biblioteca padrao afeta TUDO que inclui
#     Enumerable no processo inteiro (risco de colisao de nome com alguma
#     gem, ou de confundir quem le codigo sem saber que Enumerable foi
#     "expandido")
#   - mais dificil de "desligar" ou isolar em teste (o metodo passa a
#     existir globalmente assim que o arquivo é carregado)
#
# Metodo solto (palindrome_sem_mixin?):
#   + nao mexe em nenhuma classe existente, zero risco de colisao
#   + facil de achar com grep/ir-para-definicao (fica onde foi definido)
#   - call site fica menos "bonito": palindrome_sem_mixin?(colecao) em vez
#     de colecao.palindrome? (perde o charme do duck typing/mixin)
#
# Sem yield explicito (to_a/reverse, original):
#   + usa metodos prontos e testados da stdlib, menos codigo pra manter
#   + reverse ja e otimizado internamente
#   - "esconde" como a inversao realmente acontece (bom pra produtividade,
#     ruim pra estudar como iteradores funcionam por dentro)
#
# Com yield explicito (each_backwards):
#   + mostra o mecanismo por baixo dos panos -- ótimo pra aprender como
#     Array#each/#reverse são implementaveis na mao com yield
#   - reinventa a roda: mais codigo, mais chance de bug (off-by-one no
#     indice i), e provavelmente mais lento que o Array#reverse nativo em C

def check(desc, expected, actual)
  if expected == actual
    puts "OK     #{desc}"
  else
    puts "FALHOU #{desc} (esperado #{expected.inspect}, obtido #{actual.inspect})"
  end
end

check("sem mixin: array palindromo verdadeiro", true, palindrome_sem_mixin?([1, 2, 3, 2, 1]))
check("sem mixin: array palindromo falso", false, palindrome_sem_mixin?([1, 2, 3]))

check("com yield: array palindromo verdadeiro", true, palindrome_com_yield?([1, 2, 3, 2, 1]))
check("com yield: array palindromo falso", false, palindrome_com_yield?([1, 2, 3]))
