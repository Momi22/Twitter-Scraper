# frozen_string_literal: true

class CreateTwitterScrapers < ActiveRecord::Migration[6.0]
  def change
    create_table :twitter_scrapers do |t|
      t.bigint :ref_id, null: false
      t.text :text, null: false
      t.string :screen_name

      t.timestamps
    end
  end
end
