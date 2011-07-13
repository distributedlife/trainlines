require 'spec_helper'

describe TrainlinesController do
  context '"GET" edit' do
    before(:each) do
      Location.create(:name => "Footscray Station", :lat => 3, :lng => 3)
      Location.create(:name => "Yarraville Station", :lat => 3, :lng => 3)

      @route = Routes.create(:name => "My Route")
      @stop1 = Stops.create(:routes_id => @route.id, :name => "Footscray Station")
      @stop2 = Stops.create(:routes_id => @route.id, :name => "Yarraville Station")
    end

    it 'should return the route name and stops' do
      get :edit, :id => @route.id

      assigns[:route].should == @route
      assigns[:name].should == @route.name
      assigns[:stops].should == "#{@stop1.name}\n#{@stop2.name}"
    end
  end
  
  context '"POST" create' do
    before(:each) do
      Location.create(:name => "Footscray Station", :lat => 3, :lng => 3)
      Location.create(:name => "Yarraville Station", :lat => 3, :lng => 3)
    end

    it 'should not save a route without a name' do
      Routes.count.should == 0
      Stops.count.should == 0

      post :create, :name => "", :stops => "Footscray Station, Yarraville Station", :changed => false

      Routes.count.should == 0
      Stops.count.should == 0
    end

    it 'should not save a route when changed is true' do
      Routes.count.should == 0
      Stops.count.should == 0

      post :create, :name => "Werribee Line", :stops => "Footscray Station, Yarraville Station", :changed => true

      Routes.count.should == 0
      Stops.count.should == 0
    end

    it 'save the route and its stops' do
      Stops.count.should == 0
      Routes.count.should == 0

      post :create, :name => "Werribee Line", :stops => "Footscray Station, Yarraville Station", :changed => false

      Routes.count.should == 1
      Stops.count.should == 2

      Routes.all.first.name.should == "Werribee Line"
      Stops.order(:name).all.first.name.should == "Footscray Station"
      Stops.order(:name).all.last.name.should == "Yarraville Station"
    end

    it 'should redirect to index if save successful' do
      post :create, :name => "Werribee Line", :stops => "Footscray Station, Yarraville Station", :changed => false

      response.should be_redirect
      response.should redirect_to(root_path)
    end
  end

  context '"POST" update' do
    before(:each) do
      Location.create(:name => "Footscray Station", :lat => 3, :lng => 3)
      Location.create(:name => "Sedden Station", :lat => 3, :lng => 3)
      Location.create(:name => "Yarraville Station", :lat => 3, :lng => 3)

      @route = Routes.create(:name => "My Route")
      @stop1 = Stops.create(:routes_id => @route.id, :name => "Footscray Station")
      @stop2 = Stops.create(:routes_id => @route.id, :name => "Yarraville Station")
    end

    it 'should not save a route without a name' do
      put :update, :id => @route.id, :name => "", :stops => "Footscray Station, Yarraville Station", :changed => false

      Routes.first.name.should == @route.name
    end

    it 'should not save a route when changed is true' do
      put :update, :id => @route.id, :name => "Werribee Line", :stops => "Footscray Station, Yarraville Station", :changed => true

      Routes.first.name.should == @route.name
    end

    it 'save the route and its stops' do
      put :update, :id => @route.id, :name => "Werribee Line", :stops => "Sedden Station, Yarraville Station", :changed => false

      Routes.count.should == 1
      Stops.count.should == 2

      Routes.all.first.name.should == "Werribee Line"
      Stops.order(:name).all.first.name.should == "Sedden Station"
      Stops.order(:name).all.last.name.should == "Yarraville Station"
    end

    it 'should redirect to route page if save successful' do
      put :update, :id => @route.id, :name => "Werribee Line", :stops => "Footscray Station, Yarraville Station", :changed => false

      response.should be_redirect
      response.should redirect_to(trainline_path(@route.id))
    end
  end
end