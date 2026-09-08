# Tempo, esforço e feedback final

[← Home](Home)

## Como o Claude Code participou do estudo

O Claude Code foi usado principalmente como tutor de sintaxe e parceiro de
investigação. Como eu já tinha experiência com Python, Go e C++, eu pedia que cada
construção nova fosse traduzida para uma ideia conhecida nessas linguagens e,
em seguida, solicitava um exemplo mínimo em Ruby. Esse procedimento foi usado
para entender encadeamento de métodos, blocos, `Hash`, `map`, `group_by`,
`attr_accessor`, `super`, exceções, `class_eval`, `method_missing`, mixins e
`yield`.

A resposta do LLM não era considerada suficiente por si só. Eu conferia o
significado no código, executava os exemplos, criava casos normais e inválidos
e comparava a implementação original com uma alternativa. Assim, o esforço
incluiu tanto a escrita quanto a análise crítica e a transformação da
explicação em entendimento próprio.

Esta página registra os tempos estimados, o processo de análise crítica e o
feedback pessoal sobre o uso do Claude Code durante o estudo.

## Tempo para entender cada parte

Quanto tempo levou pra entender o que cada parte pedia (ler o enunciado,
entender os exemplos, entender por que a solução proposta pelo LLM
funciona) — não o tempo de escrever código, só de compreensão.

| Parte | Tempo pra entender o enunciado | Tempo pra entender a solução proposta |
|---|---|---|
| 1 — Strings | 15min | 10min |
| 2 — Rock-Paper-Scissors | 15min | 20min |
| 3 — Anagramas | 15min | 10min |
| 4 — OOP básico | 20min | 15min |
| 5 — Metaprogramming | 20min | 40min |
| 6 — OOP avançado | 20min | 60min |

As partes mais rápidas e fáceis de entender foram aquelas em que eu já tinha
familiaridade com o problema e com o formato do algoritmo. Strings,
anagramas e a regra básica de pedra, papel e tesoura foram mais diretos nesse
sentido. As partes que exigiram mais tempo foram as de metaprogramação e OOP
avançado, porque a sintaxe e o modelo dinâmico de Ruby ainda eram pouco
familiares para mim.

## Tempo para desenvolver

Com a interação com o LLM, o trabalho de entender a sintaxe ficou mais rápido,
mas ainda foi necessário pedir explicações e exemplos durante quase todo o
desenvolvimento. No começo, eu tendia a aceitar o prompt, executar o código e
considerar a tarefa encerrada assim que os testes passavam. Com o avanço do
trabalho, passei a separar melhor três etapas: fazer o código funcionar,
entender por que ele funciona e verificar se ele realmente atende ao
enunciado.

## Tempo e esforço para analisar criticamente as respostas

O enunciado pede uma análise **criteriosa** das respostas geradas, e não
apenas a cópia do que o LLM sugeriu.

No início, aceitei várias respostas de primeira porque ainda não tinha
conhecimento suficiente de Ruby para reconhecer imediatamente quando uma
solução poderia estar inadequada. Isso revelou uma limitação importante do
uso de LLM: um código funcionar não significa automaticamente que eu entendi
o código ou que a explicação está completa.

Um cenário representativo aconteceu na Parte 6. A solução com
`method_missing`, `respond_to_missing?` e o módulo `Enumerable` funcionava nos
testes, mas eu não entendia como uma chamada como `5.dollars` poderia existir
sem um método `dollars` escrito na classe. Pedi ao Claude Code para explicar a
execução passo a passo, comparar `method_missing` com `__getattr__` do Python
e mostrar uma versão mais simples usando uma função comum. Depois, conferi o
comportamento com moedas válidas, com uma moeda inexistente e com
`respond_to?`. Esse processo foi mais útil do que apenas olhar o código
pronto.

Também precisei pedir para reduzir explicações muito longas. A primeira
resposta normalmente apresentava vários detalhes de uma vez; quando pedi uma
explicação menor, com um exemplo por vez, o conteúdo ficou mais fácil de
acompanhar. Em outros momentos, fiz o contrário e pedi para detalhar uma
parte que eu ainda não tinha entendido, principalmente `yield`, mixins e
`class_eval`.

Não identifiquei um erro claro do LLM durante a resolução. Isso não significa
que as respostas deveriam ser aceitas sem verificação: como meu conhecimento
de Ruby ainda era limitado, eu poderia não perceber um erro sutil. Por isso,
validei as soluções executando os testes do enunciado, adicionando casos
normais e inválidos, verificando as exceções e comparando as implementações
originais com as alternativas.

## Feedback final sobre a experiência
Minha avaliação é que o LLM me ajudou mais a terminar os exercícios do que a
aprender Ruby imediatamente. Isso aconteceu porque eu ainda tinha pouco
conhecimento da linguagem e muitas vezes usei a resposta como ponto de
partida, sem conseguir avaliar tudo sozinha. Mesmo assim, as explicações
foram importantes para começar a construir uma base, especialmente sobre
`yield`, mixins, métodos de coleção e metaprogramação.

O nível inicial das explicações foi excessivo para mim. Quando pedi respostas
mais curtas e exemplos menores, a interação ficou mais eficiente. Eu também
percebi que confiar no código apenas porque ele executou é uma prática ruim,
embora isso tenha acontecido algumas vezes no começo. Durante o trabalho,
fui ficando mais desconfiada e passei a comparar as respostas com o conteúdo
das aulas, com o enunciado e com os testes.

Não acredito que assistir às aulas, sem praticar, seria suficiente para
aprender a linguagem. É necessário colocar o conhecimento em prática. Sem
LLM, esse processo provavelmente seria bem mais lento, porque eu precisaria
pesquisar individualmente a sintaxe e os métodos. Por outro lado, resolver
sem ajuda pode fazer o conteúdo fixar mais rapidamente, pois exige maior
esforço de recuperação e experimentação. Com o LLM, a resposta chega mais
rápido, mas a fixação pode exigir mais exercícios e revisões posteriores.

Concluo que os dois métodos precisam de prática constante. Pretendo usar o
LLM como apoio para destravar dúvidas e comparar alternativas, mas não como
substituto da leitura do enunciado, da escrita do código, dos testes e da
tentativa de explicar a solução com minhas próprias palavras.
