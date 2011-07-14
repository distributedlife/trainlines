class Stops < ActiveRecord::Base
  attr_accessible :name, :routes_id, :pass_through

  validates :name, :presence => true
  validates :routes_id, :presence => true
end
