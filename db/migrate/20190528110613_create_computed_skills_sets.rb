class CreateComputedSkillsSets < ActiveRecord::Migration[5.2]
  def change
    create_table :computed_skills_sets do |t|
      t.references :user, foreign_key: true
      t.integer :serve
      t.integer :return
      t.integer :backhand
      t.integer :forehand
      t.integer :volley
      t.integer :speed
      t.integer :power
      t.integer :endurance

      t.timestamps
    end
  end
end
