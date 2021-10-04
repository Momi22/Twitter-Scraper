# frozen_string_literal: true

class CreateLimitations < ActiveRecord::Migration[6.0]
  def change
    create_table :limitations do |t|
      t.string :identifier, index: true, unique: true
      t.integer :maximum_resend, default: 0
      t.integer :maximum_try, default: 0
      t.datetime :resend_at
      t.datetime :try_at

      t.timestamps
    end
  end
end
