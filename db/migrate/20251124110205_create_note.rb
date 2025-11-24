class CreateNote < ActiveRecord::Migration[7.2]
  def change
    create_table :notes do |t|
      t.text :message
      t.bigint :project_id
      t.bigint :user_id
      t.timestamps
    end
    add_index :notes, :project_id
    add_index :notes, :user_id
  end
end
