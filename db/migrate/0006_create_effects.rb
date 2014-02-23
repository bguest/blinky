class CreateEffects < ActiveRecord::Migration
  def change
    create_table :effects do |t|
      t.belongs_to :instruction, index: true
      t.string :type
      t.integer :number
      t.string :data

      t.timestamps null: false
    end
    add_foreign_key :effects, :instructions
  end
end
