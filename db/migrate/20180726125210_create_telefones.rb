class CreateTelefones < ActiveRecord::Migration[5.1]
  def change
    create_table :telefones do |t|
      t.string :telefone
      t.string :ramal
      t.references :list, foreign_key: true

      t.timestamps
    end
  end
end
