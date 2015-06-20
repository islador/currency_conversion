class Currency
  def initialize(name, value, next_currency, machine)
    @name = name
    @value = value
    @next_currency = next_currency
    @machine = machine
  end

  attr_reader :name, :value, :next_currency

  def add(current_value, machine)
    if current_value - value > 0
      machine.add_change(self)
      current_value = current_value - value
      add(current_value, machine)
    else
      check_next_currency
    end
  end

  def check_next_currency
    unless next_currency.nil?
      next_currency.add
    end
  end
end
