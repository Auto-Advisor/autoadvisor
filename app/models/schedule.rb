class Schedule < ActiveRecord::Base

  has_many :time_slot
  belongs_to :user

end
