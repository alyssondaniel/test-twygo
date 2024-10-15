# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.references :course, null: false, foreign_key: true
      t.string :url, null: false

      t.timestamps
    end
  end
end
