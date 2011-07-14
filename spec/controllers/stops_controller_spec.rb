require 'spec_helper'

describe StopsController do
  context '"GET" index' do
    it 'should return all stop names' do
      stop1 = Stops.create(:routes_id => 1, :name => "stop one", :pass_through => true)
      stop2 = Stops.create(:routes_id => 1, :name => "stop two", :pass_through => false)
      stop3 = Stops.create(:routes_id => 3, :name => "stop three", :pass_through => false)
      stop4 = Stops.create(:routes_id => 3, :name => "stop three", :pass_through => false)

      get :index

      assigns[:stops][0].name.should == stop1.name
      assigns[:stops][1].name.should == stop3.name
      assigns[:stops][2].name.should == stop2.name

      assigns[:stops].length.should == 3
    end
  end

  context '"GET" show' do
    it 'should return a stop' do
      stop1 = Stops.create(:routes_id => 1, :name => "stop one", :pass_through => true)
      stop2 = Stops.create(:routes_id => 1, :name => "stop two", :pass_through => false)
      stop3 = Stops.create(:routes_id => 3, :name => "stop three", :pass_through => false)

      get :show, :id => stop1.id

      assigns[:stop].should == stop1
      assigns[:new_name].should == ""
    end
  end

  context '"PUT" update' do
    it 'should update the stop name' do
      stop1 = Stops.create(:routes_id => 1, :name => "stop one", :pass_through => true)

      put :update, :id => stop1.id, :new_name => "banana"

      stop1.reload
      stop1.name.should == "banana"
    end

    it 'should not update a stop if the new name is empty' do
      stop1 = Stops.create(:routes_id => 1, :name => "stop one", :pass_through => true)

      put :update, :id => stop1.id, :new_name => ""

      assigns[:new_name].should == ""
    end

    it 'should update all matching stop names' do
      stop1 = Stops.create(:routes_id => 1, :name => "stop one", :pass_through => true)
      stop2 = Stops.create(:routes_id => 1, :name => "stop one", :pass_through => false)
      stop3 = Stops.create(:routes_id => 3, :name => "stop three", :pass_through => false)

      put :update, :id => stop1.id, :new_name => "banana"

      stop1.reload
      stop1.name.should == "banana"
      stop2.reload
      stop2.name.should == "banana"
    end
  end
end
