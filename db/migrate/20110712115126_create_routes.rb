class CreateRoutes < ActiveRecord::Migration
  def self.up
    create_table :routes do |t|
      t.timestamps
    end

    create_table :stops do |t|
      t.references :routes
      t.text :name, :null => false
    end
  end

  def self.down
    drop_table :stops
    drop_table :routes
  end
end
