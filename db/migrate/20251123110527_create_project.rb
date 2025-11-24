class CreateProject < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.bigint :user_id
      t.text :description
      t.timestamps
    end
    add_index :projects, :user_id
  end
end
