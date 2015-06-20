require 'spec_helper'

require_relative '../model/machine'

describe Machine do
  before do
    @machine = Machine.new()
  end

  subject {@machine}

  describe "make_change" do
  end

  describe "add_root_currency" do
  end

  #Currency has to know about machine and vice versa, but machine just owns change
end
