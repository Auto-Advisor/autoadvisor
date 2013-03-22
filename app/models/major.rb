class Major < ActiveRecord::Base
  attr_accessible :degree, :dept, :name, :users
  has_and_belongs_to_many :users
end
