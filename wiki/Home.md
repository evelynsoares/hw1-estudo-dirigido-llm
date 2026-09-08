# Estudo dirigido: como LLM pode promover o aprendizado e o desenvolvimento de aplicações Ruby?

**Autor(a):** Evelyn Soares
**Disciplina:** Engenharia de Software (ES2026)
**Base prática:** Homework 1 — Ruby Calisthenics
**LLM usada:** Claude (via Claude Code), modelo Sonnet 5, Anthropic

## Tema

Este estudo dirigido usa a resolução do Homework 1 como laboratório prático
para discutir como um LLM pode apoiar quem está aprendendo Ruby: gerando
soluções, explicando o raciocínio por trás de cada algoritmo, propondo
implementações alternativas para comparação (paradigmas, estruturas de
dados, metaprogramming) e servindo de "par de programação" disponível a
qualquer momento.

## Fundamentação teórica e papel do LLM

O uso do Claude Code foi tratado como uma forma de **scaffolding**: um apoio
temporário para construir conhecimento enquanto eu aprendia uma linguagem
nova. O LLM podia sugerir uma solução, traduzir uma construção de Ruby para
uma ideia que eu já conhecia em Python ou C++, e criar exemplos pequenos para
teste. A compreensão, porém, não foi considerada pronta só porque o código
executou.

O processo combinou quatro etapas: decompor o enunciado, perguntar sobre a
sintaxe desconhecida, testar a hipótese e explicar novamente o algoritmo com
minhas próprias palavras. Isso aproxima o uso do LLM de uma aprendizagem
ativa: a resposta é um objeto para investigar, comparar e criticar, e não uma
resposta final para copiar. A execução dos testes funciona como uma evidência
objetiva, enquanto a explicação e, algumas vezes, a comparação com Python/C++ 
ajudam a formar um modelo mental transferível para outros problemas.

Esse método também reduziu a carga cognitiva inicial de Ruby. Em vez de tentar
aprender ao mesmo tempo o algoritmo, a sintaxe, os blocos, os enumeráveis e a
metaprogramação, é possível isolar uma construção por vez. Por outro lado,
o LLM pode produzir código plausível com uma explicação incorreta ou
incompleta. Por isso, a responsabilidade pela solução permaneceu comigo:
conferir o enunciado, executar casos normais e inválidos, comparar
alternativas e registrar limitações.

## Sumário

1. [Parte 1 — Strings (palíndromo e contagem de palavras)](Parte-1-Strings)
2. [Parte 2 — Rock-Paper-Scissors](Parte-2-RPS)
3. [Parte 3 — Anagramas](Parte-3-Anagramas)
4. [Parte 4 — OOP básico (Dessert/JellyBean)](Parte-4-OOP-Basico)
5. [Parte 5 — Metaprogramming (`attr_accessor_with_history`)](Parte-5-Metaprogramming)
6. [Parte 6 — OOP avançado (conversão de moeda, mixins)](Parte-6-OOP-Avancado)
7. [Implementações alternativas (vantagens/desvantagens)](Implementacoes-Alternativas)
8. [Tempo, esforço e feedback final](Tempo-Esforco-e-Feedback)

## Metodologia

Cada exercício foi resolvido em conjunto com o LLM: o enunciado original
(PDF `HW1RubyCalisthenics.pdf`) foi fornecido como contexto, o LLM propôs
uma implementação com comentários explicando o raciocínio de resolução
*antes* do código, e cada solução foi validada rodando os checks de teste
(`ruby partN.rb`) até todos passarem (`OK`). O código completo está em
[`hw1/`](https://github.com/evelynsoares/hw1-estudo-dirigido-llm/tree/main/hw1) neste
repositório.

Em cada parte, a conversa com o Claude Code foi usada principalmente para
entender o vocabulário de Ruby. Exemplos de perguntas foram: "qual é a
equivalência desta construção em Python e C++?", "o que este bloco devolve?",
"por que `super` é necessário aqui?" e "qual caso de erro este teste cobre?".
Depois, pedi exemplos mínimos em vez de aceitar apenas uma explicação
abstrata. Esse registro aparece nas páginas individuais, junto com as
diferenças entre o estilo de Ruby e as linguagens que eu já conhecia.

## Validação das soluções

As seis soluções foram executadas localmente com Ruby 3.4. Todos os checks
dos arquivos `hw1/part1.rb` a `hw1/part6.rb` terminaram com `OK`, incluindo
casos normais, entradas inválidas, exceções, estruturas aninhadas e
isolamento do histórico entre instâncias. As implementações alternativas
também foram executadas separadamente, conforme os comandos descritos no
README.
