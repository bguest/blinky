class CreateSequences < ActiveRecord::Migration
  def change
    create_table :sequences do |t|
      t.belongs_to :sign, index: true
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :sequences, :signs
  end
end
