# Estudo dirigido: como LLM pode promover o aprendizado e o desenvolvimento de aplicações Ruby?

**Autor(a):** Evelyn Soares
**Disciplina:** Engenharia de Software (ES2026)
**Base prática:** Homework 1 — Ruby Calisthenics (Partes 1 a 6; a Parte 7 foi
removida do enunciado e adiada para o Homework 2)
**LLM usada:** Claude (via Claude Code), modelo Sonnet 5, Anthropic

## Tema

Este estudo dirigido usa a resolução do Homework 1 como laboratório prático
para discutir como um LLM pode apoiar quem está aprendendo Ruby: gerando
soluções, explicando o raciocínio por trás de cada algoritmo, propondo
implementações alternativas para comparação (paradigmas, estruturas de
dados, metaprogramming) e servindo de "par de programação" disponível a
qualquer momento.

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
[`hw1/`](https://github.com/<usuario>/<repo>/tree/main/hw1) neste
repositório.
