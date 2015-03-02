class Product < ActiveRecord::Base
  enum status: ['active', 'archived']
end
