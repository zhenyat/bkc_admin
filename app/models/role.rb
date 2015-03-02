class Role < ActiveRecord::Base
  has_many :users
  enum status: ['active', 'archived']
end
