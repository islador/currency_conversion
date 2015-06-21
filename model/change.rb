class Change
  def initialize
    @amounts = {}
    @currencies = {}
  end

  attr_accessor :amounts, :currencies

  def add_currency(currency)
    raise ArgumentError, "add_currency only accepts currencies." if currency.class != Currency
    if @currencies["#{currency.name}"].nil?
      @amounts.store("#{currency.name}", 1)
      @currencies.store("#{currency.name}", currency)
    else
      @amounts["#{currency.name}"] += 1
    end
  end

  def reset
    @amounts = {}
    @currencies = {}
  end

  def to_s
    output_string = "Change:\n"
    @amounts.each_pair do |key, value|
      if value > 1
        output_string = output_string + "#{value} #{currencies["#{key}"].plural_name}\n"
      else
        output_string = output_string + "#{value} #{key}\n"
      end
    end
    return output_string
  end
end
