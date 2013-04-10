class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :gpa, :credit_hours, :grade_points

  has_many :credits
  has_and_belongs_to_many :sections
  has_and_belongs_to_many :majors

  def credit_hours
    self.credits.sum(:units)
  end

  def grade_points
    self.credits.sum(:points)
  end

  def recalculate_credits
    self.credit_hours = self.credits.sum(:units)
    self.grade_points = self.credits.sum(:points)
    self.gpa =  self.grade_points / self.credit_hours
    save
  end

  def schedule
    self.sections
  end

  def transcript
    self.credits
  end

  def satisfies_requirements?(constraints_hash, requirement_slots)
    # pull the user's credits into memory then do the requirements queries manually.
    # Users will have few enough credits (hopefully) that this is a performance gain.
    credits = self.credits.all
    # each requirement is an array of collection IDs.
    requirements.collect do |req|
      satisfied = true
      req.each do |constraint_id|
        constraint = constraints_hash[constraint_id]
        if !credit.satisfies_constraint? constraint
          satisfied = false
          break
        end
      end
      satisfied
    end
  end
end
