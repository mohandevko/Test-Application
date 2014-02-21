class Location < ActiveRecord::Base
  validates :name,:tag,:presence => true
end
