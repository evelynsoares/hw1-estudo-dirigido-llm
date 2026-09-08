CURRENCIES_TO_DOLLARS = {
  dollar: 1.0,
  euro: 1.292,
  rupee: 0.019,
  yen: 0.013
}.freeze

def singular_currency(currency)
  currency.to_s.sub(/s$/, '').to_sym
end

def convert_currency(amount, from, to)
  source = singular_currency(from)
  target = singular_currency(to)
  dollars = amount * CURRENCIES_TO_DOLLARS.fetch(source)
  dollars / CURRENCIES_TO_DOLLARS.fetch(target)
end

def check_in_delta(description, expected, actual, delta = 0.0001)
  if (expected - actual).abs <= delta
    puts "OK     #{description}"
  else
    puts "FALHOU #{description}"
  end
end

check_in_delta('explicit dollars to euros', 5 / 1.292,
               convert_currency(5, :dollars, :euros))
check_in_delta('explicit euros to rupees', (10 * 1.292) / 0.019,
               convert_currency(10, :euros, :rupees))
