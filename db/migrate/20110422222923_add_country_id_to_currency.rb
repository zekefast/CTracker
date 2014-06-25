class AddCountryIdToCurrency < ActiveRecord::Migration
  def self.up
    change_table :currencies do |t|
      t.references :country, index: true

      # GOTCHA: t.change is required because "null: false" does not work on t.references.
      t.change :country_id, :integer, null: false
    end
  end

  def self.down
    remove_column :currencies, :country_id
  end
end
