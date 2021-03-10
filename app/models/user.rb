class User < ApplicationRecord
  include PgSearch::Model

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :lockable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  has_many :packages, dependent: :destroy
  has_many :shipments, through: :packages

  pg_search_scope :search_by_name_and_email,
    against: { email: "C" },
    associated_against: {
      profile: { first_name: "B", last_name: "A", phone: "C" }
    },
    using: {
      tsearch: { prefix: true }
    }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # Auto remember user on Login
  def remember_me
    true
  end
end
