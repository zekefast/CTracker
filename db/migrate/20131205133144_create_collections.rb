class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.references :countries_currency, null: false, index: true
      t.references :user, null: false, index: true

      t.foreign_key :countries_currencies
      t.foreign_key :users
      t.index %i[countries_currency_id user_id], unique: true

      t.timestamps
    end
  end
end
