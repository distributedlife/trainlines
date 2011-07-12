class Stops < ActiveRecord::Base
  attr_accessible :name, :routes_id

  validates :name, :presence => true
  validates :routes_id, :presence => true
end
