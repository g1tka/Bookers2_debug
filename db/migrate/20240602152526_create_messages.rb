class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :send_user_id
      t.integer :receive_user_id
      t.text :chat

      t.timestamps
    end
  end
end
