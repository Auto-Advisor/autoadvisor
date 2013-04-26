class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password,:gpa, :password_confirmation

  has_many :credits
  has_and_belongs_to_many :sections
  has_and_belongs_to_many :majors


  def calculate_gpa
    self.gpa = self.credits.average(:grade)
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
