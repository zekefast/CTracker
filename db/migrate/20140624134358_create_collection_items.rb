class CreateCollectionItems < ActiveRecord::Migration
  def change
    create_table :collection_items do |t|
      t.references :user,     null: false, index: true
      t.references :currency, null: false, index: true

      t.index %i[user_id currency_id], unique: true

      t.timestamps
    end

    remove_column :countries, :visited
  end
end
