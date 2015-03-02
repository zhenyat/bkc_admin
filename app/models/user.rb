class User < ActiveRecord::Base
  belongs_to :role
  enum status: ['active', 'archived']
end
