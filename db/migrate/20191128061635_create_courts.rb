class CreateCourts < ActiveRecord::Migration[5.2]
  def change
    create_table :courts do |t|
      t.string :name
      t.string :surface
      t.boolean :indoor, default: false
      t.boolean :single, default: false
      t.boolean :lights, default: false
      t.boolean :water, default: false

      t.timestamps
    end
  end
end
