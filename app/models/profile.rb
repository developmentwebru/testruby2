class Profile < ApplicationRecord
  belongs_to :user

  has_many :passport_photos, dependent: :destroy
  accepts_nested_attributes_for :passport_photos, allow_destroy: true, reject_if: proc { |a| a[:image].blank? }

  validates :first_name, :last_name, :phone, :address, :city, presence: true
  validates :passport_photos, presence: true
end
