class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :relationships
  has_many :undertakes, through: :relationships, source: :job
  
  def apply(job)
    relationships.find_or_create_by(job_id: job.id)
  end

  def withdraw(job)
    relationship = relationships.find_by(job_id: job.id)
    relationship.destroy if relationship
  end
  
  def undertaking?(job)
    self.undertakes.include?(job)
  end
  
  def self.search(search)
      return Job.all unless search
      Job.where(['content LIKE ?', "%#{search}%"])
  end
  
end
