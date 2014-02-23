class CreateSigns < ActiveRecord::Migration
  def change
    create_table :signs do |t|
      t.text :letter_order

      t.timestamps
    end
  end
end
