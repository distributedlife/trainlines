require 'spec_helper'

describe Stops do
  context 'to be valid' do
    it 'should require a name' do
      r = Routes.create

      s = Stops.new
      s.routes_id = r.id
      s.valid?.should be false
      s.name = 'Streetsville'
      s.valid?.should be true
    end

    it 'should require a route' do
      s = Stops.new(:name => "Baranby Stop")
      s.valid?.should be false
      s.routes_id = 1
      s.valid?.should be true
    end
  end
end
