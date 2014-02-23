class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.belongs_to :sequence, index: true
      t.integer :number
      t.text    :phrase
      t.float   :duration

      t.timestamps
    end

    add_foreign_key :instructions, :sequences
  end
end
