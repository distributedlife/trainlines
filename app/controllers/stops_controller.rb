class StopsController < ApplicationController
  def index
    @stops = []
    last_stop = ""
    Stops.order(:name).all.each do |stop|
      next if stop.name == last_stop

      last_stop = stop.name
      @stops << stop
    end
  end

  def show
    begin
      @stop = Stops.find(params[:id])
      @location = Location.where(:name => @stop.name).first

      @new_name = ""
    rescue
      redirect_to stops_path
    end
  end

  def update
    begin
      @new_name = params[:new_name]
      return redirect_to stop_path(params[:id]) if @new_name.empty?

      
      stop = Stops.find(params[:id])
      Stops.where(:name => stop.name).each do |stop_to_be_renamed|
        stop_to_be_renamed.name = params[:new_name]
        stop_to_be_renamed.save
      end

      redirect_to stops_path
    rescue
      redirect_to stops_path
    end
  end
end
