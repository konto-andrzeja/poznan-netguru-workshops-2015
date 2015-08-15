class Student < ActiveRecord::Base
  has_many :participations, dependent: :destroy
  has_many :subject_items, through: :participations
  has_many :subject_item_notes, dependent: :destroy
  has_many :tuition_payments, dependent: :destroy

  accepts_nested_attributes_for :subject_items

  validates :first_name, :last_name, presence: true
  validates :birthdate, inclusion: {in: Date.today - 150.years..Date.yesterday, message: 'is not in the past or you are too old'}, allow_nil: true
end
