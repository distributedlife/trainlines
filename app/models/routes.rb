class Routes < ActiveRecord::Base
  attr_accessible :name, :routes_id

  validates :name, :presence => true
end
