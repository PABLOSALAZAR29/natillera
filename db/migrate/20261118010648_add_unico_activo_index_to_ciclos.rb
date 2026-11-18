class AddUnicoActivoIndexToCiclos < ActiveRecord::Migration[8.0]
  def change
     add_index :ciclos, :estado, unique: true, where: "estado = 0",
            name: "index_ciclos_on_unico_activo"
  end
end
