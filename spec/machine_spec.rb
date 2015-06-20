require 'spec_helper'

require_relative '../model/machine'

describe Machine do
  before do
    @machine = Machine.new()
    @hundred = Currency.new("Hundred", 10000, @fifty, @machine)
    @machine.largest_currency = @hundred
  end

  subject {@machine}

  it { is_expected.to respond_to(:change) }
  it { is_expected.to respond_to(:largest_currency) }

  describe "make_change" do
    it "calls largest_currency.add" do
      expect(@hundred).to receive(:add)
      @machine.make_change(100.00)
    end

    it "calls change.to_s" do
      expect(@machine.change).to receieve(:to_s)
      @machine.make_change(100.00)
    end
  end

  # Machine.add_currency functions as a wrapper for change.add_currency to shield Currency
  # from an unnecessary interdependency.
  describe "add_currency" do
    it "calls change.add_currency" do
      expect(@machine.change).to receieve(:add_currency)
      @machine.add_currency(Currency.new("Hundred", 10000, @fifty, @machine))
    end
  end
end
