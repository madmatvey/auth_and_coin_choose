class CreatePhones < ActiveRecord::Migration[5.1]
  def change
    create_table :phones do |t|
      t.string :country_code
      t.string :normalized_number
      t.boolean :active
      t.boolean :valid_number
      t.integer :user_id

      t.timestamps
    end
  end
end
