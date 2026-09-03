# Alternativa a Parte 1: mesma coisa, estilo IMPERATIVO em vez de FUNCIONAL
#
# A solucao original (hw1/part1.rb) e funcional: encadeia metodos que
# transformam a string (downcase -> gsub -> reverse) e so no fim compara,
# sem guardar estado intermediario nem usar loop. Aqui refaco as duas
# funcoes de forma imperativa: uso variaveis mutaveis, indices, e loops
# explicitos (while/for) pra construir o resultado passo a passo.
#
# Objetivo e comparar, nao "melhorar": o enunciado original ate PROIBE loop
# em palindrome?, entao esta versao serve so pra estudo dirigido (vantagens/
# desvantagens de cada estilo), nao e a entrega valida da Parte 1.

def palindrome_imperativo?(string)
  cleaned = ''
  i = 0
  while i < string.length
    char = string[i].downcase
    cleaned << char if char =~ /\w/
    i += 1
  end

  left = 0
  right = cleaned.length - 1
  while left < right
    return false if cleaned[left] != cleaned[right]
    left += 1
    right -= 1
  end
  true
end

def count_words_imperativo(string)
  counts = {}
  for word in string.downcase.scan(/\b\w+\b/)
    if counts.key?(word)
      counts[word] += 1
    else
      counts[word] = 1
    end
  end
  counts
end

# ---------------------------------------------------------------------------
# comparacao: funcional (original) x imperativo (este arquivo)
# ---------------------------------------------------------------------------
#
# Funcional (original):
#   + mais curto, mais dificil de introduzir bug de indice fora do limite
#   + method chaining deixa a intencao explicita (downcase -> limpa -> compara)
#   + sem estado mutavel pra rastrear mentalmente
#   - menos obvio pra quem nunca viu regex/gsub (\W, \b) o que esta rolando
#   - mais dificil de colocar um breakpoint "no meio" de uma cadeia de metodos
#
# Imperativo (este arquivo):
#   + passo a passo explicito, mais facil de debugar com prints/breakpoints
#   + nao depende de regex pra quem esta aprendendo (so precisa de String#=~)
#   - mais codigo, mais lugares pra errar (off-by-one em left/right, i/right)
#   - estado mutavel (cleaned, left, right, counts) precisa ser rastreado
#     mentalmente pra garantir que esta correto
#   - enunciado original proibe loop pra palindrome?, entao essa versao nem
#     seria uma resposta valida da Parte 1

def check(desc, expected, actual)
  if expected == actual
    puts "OK     #{desc}"
  else
    puts "FALHOU #{desc} (esperado #{expected.inspect}, obtido #{actual.inspect})"
  end
end

check("imperativo: palindrome? frase com pontuacao",
      true, palindrome_imperativo?("A man, a plan, a canal -- Panama"))
check("imperativo: palindrome? falso",
      false, palindrome_imperativo?("Abracadabra"))
check("imperativo: count_words exemplo do enunciado",
      { 'a' => 3, 'man' => 1, 'canal' => 1, 'panama' => 1, 'plan' => 1 },
      count_words_imperativo("A man, a plan, a canal -- Panama"))
