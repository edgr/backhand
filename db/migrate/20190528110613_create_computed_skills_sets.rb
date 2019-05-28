class CreateComputedSkillsSets < ActiveRecord::Migration[5.2]
  def change
    create_table :computed_skills_sets do |t|
      t.references :user, foreign_key: true
      t.float :serve, default: 5
      t.float :return, default: 5
      t.float :backhand, default: 5
      t.float :forehand, default: 5
      t.float :volley, default: 5
      t.float :speed, default: 5
      t.float :power, default: 5
      t.float :endurance, default: 5

      t.timestamps
    end
  end
end
