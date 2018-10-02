class CreateLis < ActiveRecord::Migration[5.1]
  def change
    create_table :lis do |t|
      t.string :set

      t.timestamps
    end
  end
end
