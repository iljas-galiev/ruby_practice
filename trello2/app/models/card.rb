class Card < ApplicationRecord
  include AuthHelper
  before_save { self.name = name.upcase; }
  validates :name, presence: true, length: { maximum: 255 }

  has_many :tasks, foreign_key: "card_id"
  scope :not_archive, -> { where("created_at > ?", 1.month.ago.to_i) }
  scope :archive, -> { where("created_at <= ?", 1.month.ago.to_i) }

  scope :user, -> (user_id) { where("user_id = ?", user_id) }
end
