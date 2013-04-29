require 'json'

class Schedule < ActiveRecord::Base
  attr_accessible :name, :sections, :user

  def as_json(opts={})
    {'id' => id, 'name' => name, 'sections' => sections, 'user_id' => user.id}
  end

  def self.random_json
    schedule = Schedule.new
    schedule.name = ""
    schedule.sections = Section.all.sample(4)
    schedule.user = User.first
    JSON.pretty_generate(schedule.as_json)
  end

  belongs_to :user
  has_and_belongs_to_many :sections
end
