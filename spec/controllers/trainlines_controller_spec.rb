require 'spec_helper'

describe TrainlinesController do
  before(:each) do
    Location.create(:name => "Footscray Station", :lat => 3, :lng => 3)
    Location.create(:name => "Yarraville Station", :lat => 3, :lng => 3)
    Location.create(:name => "Sedden Station", :lat => 3, :lng => 3)
  end

  context '"GET" edit' do
    before(:each) do
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
    it 'should not save a route without a name' do
      Routes.count.should == 0
      Stops.count.should == 0

      post :create, :name => "", :stops => "Footscray Station, Yarraville Station", :changed => "false"

      Routes.count.should == 0
      Stops.count.should == 0
    end

    it 'should not save a route when changed is true' do
      Routes.count.should == 0
      Stops.count.should == 0

      post :create, :name => "Werribee Line", :stops => "Footscray Station, Yarraville Station", :changed => "true"

      Routes.count.should == 0
      Stops.count.should == 0
    end

    it 'save the route and its stops' do
      Stops.count.should == 0
      Routes.count.should == 0

      post :create, :name => "Werribee Line", :stops => "Footscray Station, Yarraville Station", :changed => "false"

      Routes.count.should == 1
      Stops.count.should == 2

      Routes.all.first.name.should == "Werribee Line"
      Stops.order(:name).all.first.name.should == "Footscray Station"
      Stops.order(:name).all.last.name.should == "Yarraville Station"
    end

    it 'should save stops with an asterisk as pass through' do
      Stops.count.should == 0
      Routes.count.should == 0

      post :create, :name => "Werribee Line", :stops => "Footscray Station*, Yarraville Station", :changed => "false"

      Routes.count.should == 1
      Stops.count.should == 2

      Routes.all.first.name.should == "Werribee Line"
      Stops.order(:name).all.first.name.should == "Footscray Station"
      Stops.order(:name).all.first.pass_through.should == true
      Stops.order(:name).all.last.name.should == "Yarraville Station"
      Stops.order(:name).all.last.pass_through.should == false
    end

    it 'should redirect to index if save successful' do
      post :create, :name => "Werribee Line", :stops => "Footscray Station, Yarraville Station", :changed => "false"

      response.should be_redirect
      response.should redirect_to(root_path)
    end
  end

  context '"POST" update' do
    before(:each) do
      @route = Routes.create(:name => "My Route")
      @stop1 = Stops.create(:routes_id => @route.id, :name => "Footscray Station")
      @stop2 = Stops.create(:routes_id => @route.id, :name => "Yarraville Station")
    end

    it 'should not save a route without a name' do
      put :update, :id => @route.id, :name => "", :stops => "Footscray Station, Yarraville Station", :changed => "false"

      Routes.first.name.should == @route.name
    end

    it 'should not save a route when changed is true' do
      put :update, :id => @route.id, :name => "Werribee Line", :stops => "Footscray Station, Yarraville Station", :changed => "true"

      Routes.first.name.should == @route.name
    end

    it 'save the route and its stops' do
      put :update, :id => @route.id, :name => "Werribee Line", :stops => "Sedden Station, Yarraville Station", :changed => "false"

      Routes.count.should == 1
      Stops.count.should == 2

      Routes.all.first.name.should == "Werribee Line"
      Stops.order(:name).all.first.name.should == "Sedden Station"
      Stops.order(:name).all.last.name.should == "Yarraville Station"
    end

    it 'should save stops with an asterisk as pass through' do
      post :update, :id => @route.id, :name => "Werribee Line", :stops => "Footscray Station*, Yarraville Station", :changed => "false"

      Routes.count.should == 1
      Stops.count.should == 2

      Routes.all.first.name.should == "Werribee Line"
      Stops.order(:name).all.first.name.should == "Footscray Station"
      Stops.order(:name).all.first.pass_through.should == true
      Stops.order(:name).all.last.name.should == "Yarraville Station"
      Stops.order(:name).all.last.pass_through.should == false
    end

    it 'should redirect to route page if save successful' do
      put :update, :id => @route.id, :name => "Werribee Line", :stops => "Footscray Station, Yarraville Station", :changed => "false"

      response.should be_redirect
      response.should redirect_to(trainline_path(@route.id))
    end
  end

  context '"GET" index' do
    it 'should return all routes' do
      route = Routes.create(:name => "my route")
      stop = Stops.create(:routes_id => route.id, :name => "Footscray Station")

      get :index

      assigns[:geocoded_routes].count.should == 1
    end

    it 'should not return discontinued routes' do
      route = Routes.create(:name => "my route", :discontinued => Time.now)
      stop = Stops.create(:routes_id => route.id, :name => "Footscray Station")

      get :index

      assigns[:geocoded_routes].count.should == 0
    end
  end

  context '"GET" search' do
    it 'should return all routes that match the name' do
      route = Routes.create(:name => "my route")
      stop = Stops.create(:routes_id => route.id, :name => "Footscray Station")

      get :search, :q => "mY rOutE"

      assigns[:geocoded_routes].count.should == 1
    end

    it 'should return all routes that have stops that match the name' do
      route = Routes.create(:name => "my route")
      stop = Stops.create(:routes_id => route.id, :name => "Footscray Station")

      get :search, :q => "footscray station"

      assigns[:geocoded_routes].count.should == 1
    end

    it 'should match route name parts' do
      route = Routes.create(:name => "my route")
      stop = Stops.create(:routes_id => route.id, :name => "Footscray Station")

      get :search, :q => "out"

      assigns[:geocoded_routes].count.should == 1
    end

    it 'should match stop name parts' do
      route = Routes.create(:name => "my route")
      stop = Stops.create(:routes_id => route.id, :name => "Footscray Station")

      get :search, :q => "tsc"

      assigns[:geocoded_routes].count.should == 1
    end

    it 'should not return discontinued routes' do
      route = Routes.create(:name => "my route", :discontinued => Time.now)
      stop = Stops.create(:routes_id => route.id, :name => "Footscray Station")

      get :search, :q => "my route"

      assigns[:geocoded_routes].count.should == 0
    end
  end
end