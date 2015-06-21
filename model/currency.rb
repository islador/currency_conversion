require_relative 'machine'

class Currency
  def initialize(name, plural_name, value, next_currency, machine)
    raise ArgumentError, "First arg must be a String." unless name.class == String
    raise ArgumentError, "Second arg must be a String." unless plural_name.class == String
    raise ArgumentError, "Third arg msut be an Integer." unless value.class == Fixnum
    raise ArgumentError, "Fourth arg must be nil or Currency." unless next_currency.class == Currency || next_currency.class == NilClass
    raise ArgumentError, "Fifth arg must be a Machine." unless machine.class == Machine

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
