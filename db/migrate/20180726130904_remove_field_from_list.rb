class RemoveFieldFromList < ActiveRecord::Migration[5.1]
  def change
    remove_column :lists, :ramal, :string
    remove_column :lists, :telefone, :string
  end
end
