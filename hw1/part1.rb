# Part 1: fun with strings
#
# (a) palindrome?(string)
# A frase é palindromo se após remover tudo que não é letra/numero e
# ignorar maiusculas/minusculas, a string for igual ao seu reverso
# downcase -> gsub (tudo que não for \w = [A-Za-z0-9]) -> comparação
# sem loop/iteracao explicita -> só métodos

def palindrome?(string)
  cleaned = string.downcase.gsub(/\W/, '')
  cleaned == cleaned.reverse
end

# (b) count_words(string)
# extrair todas as palavras (sequencias delimitadas por \b) da string, 
# normalizar case, e contar ocorrencias
# downcase ->  scan -> each pra contagem

def count_words(string)
  string.downcase.scan(/\b\w+\b/).each_with_object(Hash.new(0)) do |word, counts|
    counts[word] += 1
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

check("palindrome? frase com pontuacao e case misto",
      true, palindrome?("A man, a plan, a canal -- Panama"))

check("palindrome? com apostrofo",
      true, palindrome?("Madam, I'm Adam!"))

check("palindrome? falso",
      false, palindrome?("Abracadabra"))

check("count_words exemplo do enunciado",
      { 'a' => 3, 'man' => 1, 'canal' => 1, 'panama' => 1, 'plan' => 1 },
      count_words("A man, a plan, a canal -- Panama"))

check("count_words palavras curtas repetidas",
      { 'doo' => 3, 'bee' => 2 },
      count_words("Doo bee doo bee doo"))

check("count_words ignora pontuacao solta",
      { 'hello' => 1, 'world' => 1 },
      count_words("Hello -- world!"))
