# Implementações alternativas — vantagens e desvantagens

[← Home](Home)

Pra cada dimensão pedida no enunciado, foi implementada uma alternativa real
(rodável e testada, não só um esboço) ao lado da solução original, em
[`alternativas/`](https://github.com/<usuario>/<repo>/tree/main/alternativas).
As quatro comparações abaixo foram todas exploradas **em conversa com o
LLM**: pedi pra ele reescrever cada solução no estilo oposto e explicar o
porquê das diferenças — é justamente esse tipo de "e se eu tivesse feito de
outro jeito?" que fica muito mais barato de explorar com um LLM do que sem.

## 1. Funcional × Imperativo (Parte 1)

| | Funcional (original) | Imperativo (`alternativas/part1_imperativo.rb`) |
|---|---|---|
| Estilo | `downcase.gsub.reverse` encadeado, sem estado mutável | `while`/`for` com variáveis mutáveis (`cleaned`, `left`, `right`) |
| Legibilidade | Curto, intenção explícita via nomes de método | Passo a passo explícito, fácil de acompanhar com prints/breakpoint |
| Risco de bug | Baixo (sem índice manual) | Maior (off-by-one em `left`/`right`, `i`) |
| Curva de aprendizado | Exige conhecer regex (`\W`, `\b`) e `gsub` | Só precisa de `while`, índice de string, `=~` |
| Aderência ao enunciado | Atende (proíbe loop) | **Não atende** — o enunciado original proíbe loop em `palindrome?`; essa versão só serve pra comparação didática |

## 2. `Hash` × outras Collections (Parte 3)

| | `Hash` via `group_by` (original) | `Array` puro | `Set` (`alternativas/part3_outras_collections.rb`) |
|---|---|---|---|
| Complexidade | O(n) — inserção por chave | O(n²) — busca linear de grupo a cada palavra | O(n), mas ainda precisa de um `Hash` interno pra guardar os grupos |
| Código | 1 linha | Precisa de `find` + estado (`existing_group`) | Quase idêntico ao `Hash`, `Set` só ilustra "já vi essa assinatura?" |
| Conclusão | Melhor opção pro problema | Didático pra quem não viu `Hash`/hashing ainda, mas não escala | `Set` não substitui `Hash` aqui — falta "valor associado à chave", que é exatamente o que o problema precisa |

## 3. Com mixin × sem mixin (Parte 6c)

| | Mixin (`module Enumerable`, original) | Método solto (`palindrome_sem_mixin?`) |
|---|---|---|
| Uso | `colecao.palindrome?` — parece método nativo | `palindrome_sem_mixin?(colecao)` |
| Alcance | Afeta **toda** classe que inclui `Enumerable` no processo (Array, Range, Hash, Set, gems de terceiros...) | Isolado, só afeta quem chama explicitamente |
| Risco | Colisão de nome com alguma gem, ou confundir quem lê código sem saber que `Enumerable` foi "expandido" | Nenhum |
| Ergonomia de chamada | Melhor (duck typing natural) | Pior (perde o "parece nativo") |

## 4. Com `yield` explícito × sem (Parte 6c)

| | Sem `yield` (`to_a`/`reverse`, original) | Com `yield` (`each_backwards`, `alternativas/part6_yield_sem_mixin.rb`) |
|---|---|---|
| Implementação | Usa métodos prontos da stdlib | Escreve um iterador customizado na mão, usando `yield` |
| O que ensina | Nada sobre como iteradores funcionam por dentro | Mostra como `each`/`reverse` poderiam ser implementados manualmente |
| Performance | `reverse` nativo, otimizado em C | Reimplementa a roda — mais lento, mais superfície pra bug (índice `i`) |
| Quando vale a pena | Uso "de produção" | Contexto de estudo/entendimento de iteradores |

## Conclusão geral

Em todos os quatro casos, a versão "mais Ruby idiomática" (funcional, `Hash`,
mixin, sem `yield` manual) venceu em concisão e manutenibilidade — o que
condiz com o espírito do "Ruby Calisthenics" do enunciado. As alternativas
valem como material de estudo (entender o que o Ruby faz "por baixo dos
panos"), mas não como substituição da solução original em código real.
