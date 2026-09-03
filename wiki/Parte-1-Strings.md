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

## Como usei o Claude Code pra entender a sintaxe

Minha maior dificuldade nessa parte não foi o algoritmo em si, foi a
sintaxe — Ruby tem muito método "mágico" com nome curto que não existe em
Python, Go ou C++, as linguagens que mais usei ao longo do curso. Em vez de
só pedir a solução pronta, usei
o Claude Code como um dicionário interativo: toda vez que aparecia um método
novo no código gerado, eu perguntava "o que é `gsub`?", "o que é
`downcase`?" antes de aceitar a linha. Isso virou basicamente um glossário
método a método:

- **`downcase`**: devolve a string toda em minúscula. Equivale a `.lower()`
  em Python ou `strings.ToLower()` em Go — só o nome muda.
- **`gsub(padrão, substituto)`**: "global substitute". Procura *todas* as
  ocorrências do padrão (aqui um regex, `/\W/`) e troca por outra coisa
  (aqui, string vazia `''`, ou seja, remove). Equivale a `re.sub(padrão,
  '', string)` em Python, ou a `regexp.MustCompile(padrão).ReplaceAllString`
  em Go — só que em Ruby o método vem "pendurado" na própria string, não é
  função solta de um módulo separado.
- **`reverse`**: inverte a ordem dos caracteres da string.
- **`\W` vs `\w`**: `\w` é "word character" (letra, número ou `_`); `\W`
  maiúsculo é o oposto, tudo que *não* é isso (espaço, pontuação, símbolo).
  Perguntei ao Claude por que tem duas versões e a resposta foi essa
  convenção de regex: minúscula = a classe, maiúscula = a negação dela (o
  mesmo vale pra `\d`/`\D` e `\s`/`\S`).
- **`scan(padrão)`**: percorre a string e devolve um `Array` com *todos* os
  trechos que casam com o regex — diferente de `match`, que só pega a
  primeira ocorrência.
- **`\b`**: âncora de *word boundary*, não consome caractere, só marca "aqui
  começa/termina uma palavra". Pedi exemplo comparando `scan(/\w+/)` com
  `scan(/\b\w+\b/)` pra entender a diferença na prática.
- **`Hash.new(0)`**: cria um Hash com valor-padrão `0` — ou seja,
  `hash[chave_que_nao_existe]` devolve `0` em vez de `nil`. Perguntei "por
  que não dá erro ao somar numa chave que não existe" e a comparação que
  fez clicar foi com as linguagens que mais uso: em Python seria
  `collections.defaultdict(int)` (mesma ideia de "fábrica" de valor-padrão),
  em Go seria `map[string]int` já vindo com zero-value automático (`m[k]++`
  funciona mesmo pra chave nova), e em C++ seria `std::map<std::string,
  int>`, que também devolve `0` (valor-padrão de `int`) ao acessar chave
  inexistente com `operator[]`. Ruby só deixa esse comportamento explícito e
  configurável via `Hash.new(valor)`, em vez de ser implícito na linguagem.
- **`each_with_object(objeto) { |item, obj| ... }`**: itera sobre a coleção
  acumulando resultado dentro de `objeto` (aqui, o Hash), e devolve esse
  objeto no final. Em Python eu inicializaria o `dict` numa linha antes do
  `for` e faria o acúmulo dentro do loop; em Go seria o mesmo, `map` criado
  antes com `make`, depois um `for range` populando; em Ruby o
  `each_with_object` empacota as duas coisas (criação do acumulador +
  iteração) numa expressão só, o que no começo parece "mágica" mas é só
  açúcar sintático pra evitar declarar variável mutável fora do bloco.

O padrão que segui em toda a Parte 1 (e repeti nas partes seguintes) foi:
1. Pedir a solução com comentários linha a linha.
2. Isolar cada método/símbolo que eu não reconhecia e perguntar
   especificamente por ele, fora do contexto do exercício.
3. Pedir um exemplo mínimo isolado (ex.: `"abc".scan(/\w+/)` num `irb`) pra
   ver o retorno na prática antes de confiar que entendi.
4. Só então validar rodando o teste do exercício.

Isso foi mais lento que só copiar a resposta, mas foi o que realmente
resolveu meu maior problema, que é sintaxe — o algoritmo eu geralmente já
sacava rápido (raciocínio parecido com Python/Go/C++), a barreira era não
saber o vocabulário próprio de Ruby.

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
