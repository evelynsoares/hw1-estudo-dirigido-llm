# Alternativa a Parte 5: mesmo resultado (getter/setter + historico), SEM
# metaprogramming (sem reabrir Class, sem class_eval).
#
# Original (hw1/part5.rb) define attr_accessor_with_history uma unica vez,
# dentro de Class, e funciona pra QUALQUER classe/atributo futuro.
#
# Aqui faco a "mao": cada classe que precisar de historico escreve seu
# proprio getter/setter na unha. Funciona igual pro caso do Foo/bar, mas
# nao generaliza -- se eu quiser outro atributo com historico (ex.: baz),
# preciso copiar e colar o padrao de novo.

class FooSemMeta
  def bar
    @bar
  end

  def bar=(val)
    @bar_history = [nil] if @bar_history.nil?
    @bar_history << val
    @bar = val
  end

  def bar_history
    @bar_history || []
  end
end

# ---------------------------------------------------------------------------
# comparacao: com metaprogramming (original) x sem (este arquivo)
# ---------------------------------------------------------------------------
#
# Com metaprogramming (class_eval dentro de Class):
#   + DRY de verdade: escrevo o padrao "getter+setter+historico" uma vez,
#     uso em qualquer classe/atributo (attr_accessor_with_history :qualquer_coisa)
#   + escala sem esforco extra: 10 atributos com historico = 10 linhas
#   - mais dificil de debugar: o metodo bar= nao existe no codigo-fonte "a
#     olho nu", so aparece em tempo de execucao (class_eval gerou ele)
#   - exige entender conceitos avancados (Class e objeto, class_eval, self
#     dentro de contextos diferentes) -- barreira de entrada maior
#
# Sem metaprogramming (na mao):
#   + qualquer dev Ruby iniciante le e entende sem conhecer metaprogramming
#   + stack trace/debugger mostra o metodo exatamente como escrito
#   - repetitivo: 10 atributos com historico = 10 blocos de codigo quase
#     identicos copiados e colados (viola DRY)
#   - risco de inconsistencia: se corrigir um bug no padrao, precisa lembrar
#     de replicar a correcao em toda classe que usa o padrao manualmente

def check(desc, expected, actual)
  if expected == actual
    puts "OK     #{desc}"
  else
    puts "FALHOU #{desc} (esperado #{expected.inspect}, obtido #{actual.inspect})"
  end
end

f = FooSemMeta.new
check("sem metaprogramming: historico comeca vazio", [], f.bar_history)

f.bar = 3
f.bar = :wowzo
f.bar = 'boo!'
check("sem metaprogramming: historico do exemplo do enunciado",
      [nil, 3, :wowzo, 'boo!'], f.bar_history)
