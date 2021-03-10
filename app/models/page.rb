class Page < ApplicationRecord
  validates :slug, :title, :content, presence: true
  validates :slug, uniqueness: true
end
