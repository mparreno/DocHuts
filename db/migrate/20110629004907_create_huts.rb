class CreateHuts < ActiveRecord::Migration
  def self.up
    create_table :huts do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :huts
  end
end
