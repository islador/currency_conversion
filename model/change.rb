class Change
  def initialize
    @amounts = {}
  end

  attr_accessor :amounts

  def add_currency(currency)
    raise ArgumentError, "add_currency only accepts currencies." if currency.class != Currency
    if @amounts["#{currency.name}"].nil?
      @amounts.store("#{currency.name}", 1)
    else
      @amounts["#{currency.name}"] += 1
    end
  end

  def to_s
    output_string = "Change:\n"
    @amounts.each_pair do |key, value|
      output_string = output_string + "#{value} #{key}\n"
    end
    return output_string
  end
end
