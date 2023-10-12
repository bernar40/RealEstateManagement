class Property < ApplicationRecord
  belongs_to :agent, optional: true

  validates :name, :location, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: %w(Available Sold) }

  validate :validate_assignment

  private
  def validate_assignment
    if status == "Sold" && agent_id_changed?
      errors.add(:status, 'Property cannot be assigned when its status is Sold')
    end
  end
end
