# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.date :end_on, null: false

      t.timestamps
    end
  end
end
