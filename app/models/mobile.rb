class Mobile < ApplicationRecord
  validates :price, :ram, :rom, :brand_name, presence: true
  after_destroy :set_count

  def set_count
    count = Mobile.all.count
  end
end
