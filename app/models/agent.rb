class Agent < ApplicationRecord
  has_many :properties

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def fullname
    "#{first_name} #{last_name}"
  end
end
