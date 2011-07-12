require 'spec_helper'

describe Location do
  context 'to be valid' do
    it 'should require a lat' do
      l = Location.new(:lng => 3.1, :name => "Somewhere")
      l.valid?.should be false
      l.lat = 234.23423
      l.valid?.should be true
    end

    it 'should require a lng' do
      l = Location.new(:lat => 3.1, :name => "Somewhere")
      l.valid?.should be false
      l.lng = 234.23423
      l.valid?.should be true
    end

    it 'should require a name' do
      l = Location.new(:lat => 3.1, :lng => 3.21312)
      l.valid?.should be false
      l.name = 'Streetsville'
      l.valid?.should be true
    end
  end
end
