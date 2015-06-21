require 'spec_helper'

require_relative '../model/change'
require_relative '../model/currency'
require_relative '../model/machine'

describe Change do

  before do
    @change = Change.new()
    @machine = Machine.new()
  end

  subject {@change}

  it { is_expected.to respond_to(:amounts) }

  describe "add_currency" do
    it "throws an error if a currency object is not passed" do
      expect {@change.add_currency("Cash")}.to raise_error(ArgumentError)
    end

    context "amounts hash does not contain that name" do
      it "adds the currency's name to the amounts hash" do
        expect(@change.amounts["Penny"]).to be_nil
        @change.add_currency(Currency.new("Penny", 1, nil, @machine))
        expect(@change.amounts["Penny"]).not_to be_nil
      end

      it "adds a value of one to amounts['currency_name']" do
        expect(@change.amounts["Penny"]).to be_nil
        @change.add_currency(Currency.new("Penny", 1, nil, @machine))
        expect(@change.amounts["Penny"]).to be 1
      end
    end

    context "amounts hash contains that name" do
      before do
        @change.amounts.store("Penny", 1)
      end
      it "increments the value of amounts['currency_name']" do
        expect(@change.amounts["Penny"]).not_to be_nil
        expect(@change.amounts["Penny"]).to be 1
        @change.add_currency(Currency.new("Penny", 1, nil, @machine))
        expect(@change.amounts["Penny"]).to be 2
      end
    end
  end

  describe "to_s" do
    before do
      @change.amounts = {"Hundred" => 2, "Fifty" => 1, "Twenty" => 1}
    end
    it "returns a formatted string of the amounts hash" do
      expect(@change.to_s).to match "Change:\n2 Hundred\n1 Fifty\n1 Twenty\n"
    end
  end
end
