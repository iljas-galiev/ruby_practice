class Task < ApplicationRecord

  validates :title,  presence: true, length: { maximum: 255 }
  validates :checked, numericality: { less_than_or_equal_to: 1,  only_integer: true, greater_than_or_equal_to: 0 }

  scope :user, -> (user_id) { where("user_id = ?", user_id) }

  def is_checked
    self.checked > 0
  end
end
