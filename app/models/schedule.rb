class Schedule < ActiveRecord::Base
  attr_accessible :name, :sections, :user

  def as_json
    {'id' => id, 'name' => name, 'sections' => sections, 'user_id' => user.id}
  end

  belongs_to :user
  has_and_belongs_to_many :sections
end
