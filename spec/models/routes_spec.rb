require 'spec_helper'

describe Routes do
  context 'to be valid' do
    it 'should require a name' do
      r = Routes.new
      r.valid?.should be false
      r.name = 'Streetsville'
      r.valid?.should be true
    end
  end
end
