class CreateColabs < ActiveRecord::Migration[5.1]
  def change
    create_table :colabs do |t|
      t.string :nome
      t.references :list, foreign_key: true

      t.timestamps
    end
  end
end
