class Menu < ApplicationRecord
  has_many :menu_categories, dependent: :destroy
  has_many :categories, through: :menu_categories

  has_many :order_details
  has_many :orders, through: :order_details

  # rails validation
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0.01}
  validates :description, length: { maximum: 150, too_long: "%{count} characters is the maximum allowed" }

  # rails validation assosiation
  validates :categories, presence: true
end
