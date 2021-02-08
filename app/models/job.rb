class Job < ApplicationRecord
  belongs_to :company
  has_many :relationships
  
  validates :content, presence: true, length: { maximum: 255 }
  
  def self.search(search)
    return Job.all unless search
    Job.where(['content LIKE ?', "%#{search}%"])
  end
end
