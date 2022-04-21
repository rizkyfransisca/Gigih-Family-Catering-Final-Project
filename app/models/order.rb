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

  def self.filter_by_customer_email(customer_email)
    # return where(customer_email: customer_email)
    where(customer_email: customer_email)
  end

  def self.filter_by_equal_to_total_price(total_price)
    where(total_price: total_price)
  end

  def self.filter_by_date_range(start_date, end_date)
    where(order_date: start_date..end_date)
  end

  def self.filter_by_greater_than_entered_total_price(entered_total_price)
    where('total_price > ?', entered_total_price )
  end

  def self.filter_by_lower_than_entered_total_price(entered_total_price)
    where('total_price < ?', entered_total_price )
  end
end
