class TimeSlot < ActiveRecord::Base
  attr_accessible :beg_hour, :beg_min, :days, :end_hour, :end_min, :sections

  has_many :sections
end
