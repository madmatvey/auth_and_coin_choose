class CreateValidationTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :validation_tokens do |t|
      t.string :token
      t.integer :phone_id

      t.timestamps
    end
  end
end
