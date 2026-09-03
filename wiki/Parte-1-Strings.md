# Parte 1 — fun with strings

[← Home](Home)

## Enunciado (resumo)

(a) `palindrome?(string)`: diz se uma frase é palíndromo, ignorando
maiúsculas/minúsculas, pontuação e caracteres não-alfanuméricos. **Sem usar
loop/iteração** — só métodos de `String`.

(b) `count_words(string)`: devolve um `Hash` com a contagem de cada palavra
da string (case-insensitive, ignorando pontuação). Pode usar `each`, mas não
`for`.

## Solução

```ruby
def palindrome?(string)
  cleaned = string.downcase.gsub(/\W/, '')
  cleaned == cleaned.reverse
end

def count_words(string)
  string.downcase.scan(/\b\w+\b/).each_with_object(Hash.new(0)) do |word, counts|
    counts[word] += 1
  end
end
```

## Explicação do algoritmo

**`palindrome?`**: uma frase é palíndromo se, depois de tirar tudo que não é
letra/número e ignorar case, ela for igual ao próprio reverso.
`\W` é a negação de `\w` (`[A-Za-z0-9_]`), então `gsub(/\W/, '')` remove
espaços, vírgulas, hífens, exclamação etc. de uma vez, sem precisar
percorrer a string manualmente — daí não precisar de loop: a "iteração" fica
escondida dentro de `gsub` e `reverse`, que são implementados em C na
própria VM do Ruby.

**`count_words`**: `\b` é âncora de *word boundary* — `\b\w+\b` captura
sequências de caracteres alfanuméricos delimitadas por fronteiras de
palavra, então `scan` devolve só as "palavras" da string, sem pontuação
solta. `Hash.new(0)` cria um Hash cujo valor-padrão pra chave inexistente é
`0`, então `counts[word] += 1` funciona mesmo na primeira ocorrência da
palavra sem precisar checar `if counts.key?(word)` antes.

## Estruturas Ruby usadas

- `String#downcase`, `String#gsub`, `String#reverse` — normalização e
  comparação de string.
- `String#scan` com regex de *word boundary* (`\b`) — extração de palavras.
- `Hash.new(0)` (hash com valor-padrão) + `Enumerable#each_with_object` —
  contagem sem *for-loop* explícito, só iterador.

## Ver também

Comparação com uma versão **imperativa** (com `while`, sem regex) em
[Implementações alternativas](Implementacoes-Alternativas) e no código-fonte
[`alternativas/part1_imperativo.rb`](https://github.com/<usuario>/<repo>/blob/main/alternativas/part1_imperativo.rb).
