class CreateInscripciones < ActiveRecord::Migration[8.0]
  def change
    create_table :inscripciones do |t|
      t.references :persona, null: false, foreign_key: true
      t.references :ciclo, null: false, foreign_key: true
      t.integer :valor_ahorro, null: false
      t.integer :periodicidad, null: false, default: 0
      t.integer :estado, null: false ,default: 0

      t.timestamps
    end
  end
end
