class Job < ApplicationRecord
  belongs_to :company
  has_many :relationships
  
  validates :content, presence: true, length: { maximum: 255 }
end
