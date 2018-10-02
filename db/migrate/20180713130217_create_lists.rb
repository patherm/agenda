class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :nome
      t.string :setor
      t.string :ramal
      t.string :telefone

      t.timestamps
    end
  end
end
