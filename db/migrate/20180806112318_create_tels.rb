class CreateTels < ActiveRecord::Migration[5.1]
  def change
    create_table :tels do |t|
      t.string :tel
      t.string :ram
      t.references :li, foreign_key: true

      t.timestamps
    end
  end
end
