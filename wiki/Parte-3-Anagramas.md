# Parte 3 — anagramas

[← Home](Home)

## Enunciado (resumo)

`combine_anagrams(words)`: recebe um array de strings e devolve um array de
grupos, onde cada grupo contém as palavras que são anagramas entre si. Case
não importa pra agrupar, mas é preservado na saída.

## Solução

```ruby
def combine_anagrams(words)
  words.group_by { |word| word.downcase.chars.sort.join }.values
end
```

## Explicação do algoritmo

Duas palavras são anagramas se, ao ordenar suas letras, o resultado for
igual: `"cars".downcase.chars.sort` e `"racs".downcase.chars.sort` dão
`["a","c","r","s"]` nos dois casos. Essa sequência ordenada funciona como
**assinatura** — uma chave natural pra agrupar palavras que são anagramas
entre si.

`group_by` é o método certo pra esse padrão "particionar uma coleção por uma
chave derivada": ele devolve um `Hash { assinatura => [palavras com essa
assinatura] }`. Como o enunciado só quer os grupos (não as assinaturas
usadas como chave, nem a ordem deles), a solução termina com `.values`, que
descarta as chaves e devolve só os arrays de palavras agrupadas.

O `downcase` aparece só dentro do bloco que calcula a assinatura — a palavra
original (com maiúsculas/minúsculas como veio) é o que entra no array de
saída, preservando o case pedido no enunciado.

## Estruturas Ruby usadas

- `Enumerable#group_by` — particiona a coleção numa única passada, sem
  precisar de um `Hash.new { |h,k| h[k] = [] }` manual.
- `String#chars.sort.join` — "assinatura" de anagrama.

## Ver também

Comparação com agrupamento manual em `Array` e com `Set` em
[Implementações alternativas](Implementacoes-Alternativas) e no código-fonte
[`alternativas/part3_outras_collections.rb`](https://github.com/<usuario>/<repo>/blob/main/alternativas/part3_outras_collections.rb).
