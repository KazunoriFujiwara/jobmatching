class Job < ApplicationRecord
  belongs_to :company
  has_many :relationships
  
  validates :content, presence: true, length: { maximum: 255 }
  #validates :start_date, presence: true
  #validates :start_time, presence: true
  #validates :end_date, presence: true
  #validates :end_time, presence: true
  #validates :place, presence: true, length: { maximum: 255 }
  
  def self.search(search)
    return Job.all unless search
    Job.where(['content LIKE ?', "%#{search}%"])
  end
end
