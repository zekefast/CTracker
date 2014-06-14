class CreateCountriesCurrencies < ActiveRecord::Migration
  def change
    create_table :countries_currencies do |t|
      t.references :country, null: false, index: true
      t.references :currency, null: false, index: true

      t.foreign_key :countries
      t.foreign_key :currencies

      t.index %i[country_id currency_id], unique: true

      t.timestamps
    end
  end
end
