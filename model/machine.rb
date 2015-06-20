class Machine
  def initialize()
    @change = Change.new()
    @largest_currency = Currency.new()
  end

  attr_reader :change
  attr_accessor :largest_currency

  # make_change triggers the change calculation and outputs the results
  def make_change(usd_float)
    # Convert the floating point to pennies as an integer
    usd_float = usd_float * 100
    int_value = usd_float.to_i

    # Determine the currency breakdown
    largest_currency.add(int_value)

    # Print the output
    puts change.to_s
  end

  # add_currency wraps change.add_currency to shield Currency from an unnecessary interdependecy.
  def add_currency(currency)
    change.add_currency(currency)
  end
end
