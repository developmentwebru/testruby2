class Guest < ApplicationRecord
  has_many :packages
  validates :first_name, :last_name, presence: true

  after_validation :prettify_first_and_last_name

  private
    def prettify_first_and_last_name
      # Removes whitespace around name and capitalizes each word
      unless self.first_name.blank? || self.last_name.blank?
        self.first_name = self.first_name.squish
        self.last_name  = self.last_name.squish
        self.first_name = self.first_name.titleize
        self.last_name  = self.last_name.titleize
      end
    end
end
