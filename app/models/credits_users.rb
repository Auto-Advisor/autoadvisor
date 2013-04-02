class CreditsUsers < ActiveRecord::Base
  belongs_to :credit
  belongs_to :user
end
