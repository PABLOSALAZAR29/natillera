class CreateCiclos < ActiveRecord::Migration[8.0]
  def change
    create_table :ciclos do |t|
      t.string :nombre, null: false
      t.date :fecha_inicio, null: false
      t.date :fecha_fin, null: false
      t.integer :ahorro_minimo, null: false, default: 100_000
      t.integer :tasa_prestamo, null: false, default: 10
      t.integer :multa_diaria, null: false, default: 1_000
      t.integer :dias_gracia, null: false, default: 2
      t.integer :estado, null: false, default: 0

      t.timestamps
    end
  end
end
