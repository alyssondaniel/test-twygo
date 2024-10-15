# frozen_string_literal: true

class Movie < ApplicationRecord
  belongs_to :course

  validates :url, presence: true
end
