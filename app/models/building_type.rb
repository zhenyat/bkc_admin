class BuildingType < ActiveRecord::Base
  has_many :buildings
  enum status: ['active', 'archived']
end
