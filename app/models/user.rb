class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :jobs
  has_many :resumes
  has_many :letters

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_google(u)
    create_with(
      uid: u[:uid], 
      email: u[:email], 
      provider: 'google',
      password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email]
    )
  end
end
