class Transcript < ActiveRecord::Base
  
  belongs_to :user
  has_many :credits, :majors

end
