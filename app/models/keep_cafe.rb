class KeepCafe < ApplicationRecord

  belongs_to :customer
  belongs_to :cafe
  validates_uniqueness_of :cafe_id, scope: :customer_id

end
