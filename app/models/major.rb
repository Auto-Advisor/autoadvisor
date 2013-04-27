# dept = Computer Science
# name = Bachelors in Science of Computer Science
# code = CMPSCI
class Major < ActiveRecord::Base
  attr_accessible :code, :degree, :dept, :name, :users
  has_and_belongs_to_many :users
  has_many :courses
end
