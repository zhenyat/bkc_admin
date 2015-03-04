class Building < ActiveRecord::Base
  belongs_to :building_type
  enum status: ['active', 'archived']
end
