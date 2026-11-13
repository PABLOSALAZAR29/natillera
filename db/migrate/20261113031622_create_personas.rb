class CreatePersonas < ActiveRecord::Migration[8.0]
  def change
    create_table :personas do |t|
      t.string :nombre, null: false
      t.string :documento, null: false
      t.string :celular, null: false
      t.integer :tipo, null: false, default: 0
      t.boolean :activo, null: false, default: true
      t.timestamps
    end
      add_index :personas, :documento, unique: true
  end
end
