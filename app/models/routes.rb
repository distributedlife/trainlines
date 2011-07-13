class Routes < ActiveRecord::Base
  attr_accessible :name, :routes_id, :discontinued

#  validates :name, :presence => true
end
