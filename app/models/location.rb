class Location < ActiveRecord::Base
#  acts_as_mappable :default_units => :kms
  attr_accessible :name, :lat, :lng

  validates :name, :presence => true
  validates :lat, :presence => true
  validates :lng, :presence => true
end
