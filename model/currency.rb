require_relative 'machine'

class Currency
  def initialize(name, value, next_currency, machine)
    @name = name
    @value = value
    @next_currency = next_currency
    @machine = machine
  end

  attr_reader :name, :value, :next_currency, :machine

  def add(current_value)
    if current_value - value >= 0
      @machine.add_currency(self)
      current_value = current_value - value
      add(current_value)
    else
      check_next_currency(current_value)
    end
  end

  def check_next_currency(current_value)
    unless next_currency.nil?
      next_currency.add(current_value)
    end
  end
end
