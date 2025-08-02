class Note < ApplicationRecord
    # Validations - business rules
  validates :title, presence: true, length: { maximum: 200 }
  validates :content, presence: true
  
 # Scope for searching
  scope :search, ->(query) {
    where("title ILIKE ? OR content ILIKE ?", "%#{query}%", "%#{query}%") if query.present?
  }

  # Method for showing a preview
  def preview(length = 150)
    # Remove character of markdown and trunkate
    content.gsub(/[#*`_\[\]()]/, '').truncate(length)
  end
end
