class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.boolean :bitcoin
      t.boolean :lightcoin
      t.boolean :dogecoin
      t.integer :user_id

      t.timestamps
    end
  end
end
