# frozen_string_literal: true

class Course < ApplicationRecord
  has_many :movies, dependent: :nullify

  validates :title, :description, :end_on, presence: true

  scope :active, -> { where(end_on: Time.zone.today..) }
  scope :active_filter, ->(date) { active.where(end_on: date) }
end
