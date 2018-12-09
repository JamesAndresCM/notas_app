class Category < ApplicationRecord
  has_many :notes, dependent: :destroy
  validates_uniqueness_of :name
end
