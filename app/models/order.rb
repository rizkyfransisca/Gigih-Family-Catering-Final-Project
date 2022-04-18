class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :menus, through: :order_details

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :customer_email, presence: true, format: { with: VALID_EMAIL_REGEX }
  
  # rails validation assosiation
  # validates :menus, presence: true

  def self.get_todays_orders(todays_date)
    # return where(order_date: date)
    where(order_date: todays_date)
  end
end
