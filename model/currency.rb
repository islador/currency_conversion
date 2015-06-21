require_relative 'machine'

class Currency
  def initialize(name, plural_name, value, next_currency, machine)
    @name = name
    @plural_name = plural_name
    @value = value
    @next_currency = next_currency
    @machine = machine
  end

  attr_reader :name, :plural_name, :value, :next_currency, :machine

  def add(current_value)
    raise ArgumentError, "Currency.add only accepts integers." unless current_value.class == Fixnum

    if current_value - value >= 0
      @machine.add_currency(self)
      current_value = current_value - value
      add(current_value)
    else
      check_next_currency(current_value)
    end
  end

  def check_next_currency(current_value)
    raise ArgumentError, "Currency.check_next_currency only accepts integers." unless current_value.class == Fixnum

    unless next_currency.nil?
      next_currency.add(current_value)
    end
  end
end
