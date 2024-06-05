class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :check_in_date, presence: true
  validates :check_out_date, presence: true
  validates :number_of_guests, presence: true, numericality: { greater_than: 0 }
  validate :check_in_date_cannot_be_in_the_past
  validate :check_out_date_after_check_in_date

  before_save :total_price

  def calculate_total_price
    room_price_per_day = room.price.to_d
    number_of_days = (check_out_date - check_in_date).to_i
    self.total_price = (room_price_per_day * number_of_days * number_of_guests).to_i
  end

  def total_price
    calculate_total_price
  end

  private

  def check_in_date_cannot_be_in_the_past
    if check_in_date.present? && check_in_date < Date.today
      errors.add(:check_in_date, "can't be in the past")
    end
  end

  def check_out_date_after_check_in_date
    if check_out_date.present? && check_out_date <= check_in_date
      errors.add(:check_out_date, "must be after the check-in date")
    end
  end
end
