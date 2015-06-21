require_relative 'change'
require_relative 'currency'

class Machine
  def initialize
    @change = Change.new()
    @largest_currency = nil
  end

  attr_reader :change
  attr_accessor :largest_currency

  # make_change triggers the change calculation and outputs the results
  def make_change(usd_float)
    raise ArgumentError, "Machine.make_change only accepts floats." unless usd_float.class == Float
    # Convert the floating point to pennies as an integer
    usd_float = (usd_float * 100).round(2)
    int_value = usd_float.to_i
    # Determine the currency breakdown
    largest_currency.add(int_value)

    # Print the output
    puts @change.to_s

    @change.reset
  end

  # add_currency wraps change.add_currency to shield Currency from an unnecessary interdependecy.
  def add_currency(currency)
    @change.add_currency(currency)
  end
end
