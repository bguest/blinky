class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.integer :length
      t.integer :number
      t.string :color
      t.belongs_to :letter, index: true
    end
  end
end
