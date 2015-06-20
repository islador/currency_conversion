require 'spec_helper'

require_relative '../model/currency'
require_relative '../model/machine'

describe Currency do
  before do
    @machine = Machine.new()
    @fifty = instance_double("Currency", :name => "Fifty", :value => 5000, :next => nil, :machine => @machine)
    @hundred = Currency.new("Hundred", 10000, @fifty, @machine)
  end

  subject {@hundred}

  describe "Add" do
    context "current_value is 50" do
      @machine.current_value = 50
      it "does not send itself to the machine" do
        expect(@machine).not_to receive(:add)
        @hundred.add(50)
      end

      it "does not recur" do
        expect(@hundred).not_to receive(:add).twice
        @hundred.add(50)
      end
    end

    context "current_value is 100" do
      @machine.current_value = 100
      it "sends itself to 'change' once" do
        expect(@machine).to receive(:add)
        @hundred.add(100)
      end

      it "does recur once" do
        expect(@hundred).to receive(:add).exactly(2).times
        @hundred.add(100)
      end
    end
  end

  describe "next_currency" do
    context "currency.next is not nil" do
      it "runs currency.next.add" do
        expect(@fifty).to receive(:add)
        @hundred.next_currency
      end
    end
  end
end
