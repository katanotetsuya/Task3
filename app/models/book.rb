class Book < ApplicationRecord
  belongs_to :user
  validates :title, :body, presence: true, length: { maximum: 200 }
end
