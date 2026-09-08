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

## Como usei o Claude Code para entender Ruby

Eu já conhecia a ideia de ordenar letras para comparar anagramas, mas não a
forma idiomática de agrupar em Ruby. Pedi ao Claude Code para decompor
`word.downcase.chars.sort.join` e mostrar o retorno depois de cada método:

- `chars` transforma uma `String` em um `Array` de caracteres; em Python isso
  lembra `list(word)`. Em C++, seria necessário trabalhar explicitamente com
  `std::string` e seus iteradores.
- `sort` devolve os elementos ordenados e `join` reconstrói a assinatura como
  uma única string, de modo parecido com `''.join(...)` em Python.
- `group_by { |word| ... }` foi comparado com criar um dicionário em Python e
  acrescentar cada palavra a uma lista. O bloco Ruby calcula a chave e
  `.values` descarta as chaves depois do agrupamento.

Pedi ainda uma versão com `each` e `Hash.new { |hash, key| hash[key] = [] }`.
Essa comparação mostrou que `group_by` apenas encapsula o padrão de criar uma
coleção para cada chave e inserir os itens correspondentes.

## Estruturas Ruby usadas

- `Enumerable#group_by` — particiona a coleção numa única passada, sem
  precisar de um `Hash.new { |h,k| h[k] = [] }` manual.
- `String#chars.sort.join` — "assinatura" de anagrama.

## Ver também

Comparação com agrupamento manual em `Array` e com `Set` em
[Implementações alternativas](Implementacoes-Alternativas) e no código-fonte
[`alternativas/part3_outras_collections.rb`](https://github.com/evelynsoares/hw1-estudo-dirigido-llm/blob/main/alternativas/part3_outras_collections.rb).
