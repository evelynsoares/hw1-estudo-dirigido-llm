# Estudo dirigido — LLM e aprendizado de Ruby (HW1)

Entrega do estudo dirigido da disciplina de Engenharia de Software: **"Como
LLM pode promover o aprendizado e o desenvolvimento de aplicações Ruby?"**,
usando as Partes 1 a 6 do Homework 1 (Ruby Calisthenics) como base prática.

## Estrutura

- [`hw1/`](hw1/) — solução das Partes 1 a 6 (uma por arquivo, cada uma com
  comentário explicando o raciocínio e checks de teste no final).
- [`alternativas/`](alternativas/) — implementações alternativas usadas na
  seção de comparação do relatório (funcional x imperativo, `Hash` x
  `Array`/`Set`, `Hash` x `case`, `attr_accessor` x accessors manuais,
  conversão dinâmica x função explícita, com/sem metaprogramming, com/sem
  mixin, com/sem `yield`).
- [`wiki/`](wiki/) — o relatório em si, já dividido em páginas prontas pra
  virar a Wiki do repositório no GitHub (ver [Publicando no GitHub
  Wiki](#publicando-no-github-wiki) abaixo).

## Como rodar

Cada arquivo é auto-contido: roda com `ruby` e imprime `OK`/`FALHOU` pra
cada verificação, sem depender de gem externa.

```bash
ruby hw1/part1.rb
ruby hw1/part2.rb
ruby hw1/part3.rb
ruby hw1/part4.rb
ruby hw1/part5.rb
ruby hw1/part6.rb

ruby alternativas/part1_imperativo.rb
ruby alternativas/part2_case.rb
ruby alternativas/part3_outras_collections.rb
ruby alternativas/part4_manual_accessors.rb
ruby alternativas/part5_sem_metaprogramming.rb
ruby alternativas/part6_yield_sem_mixin.rb
ruby alternativas/part6_explicit_currency.rb
```
