class AddDiscontinuedToRoute < ActiveRecord::Migration
  def self.up
    add_column :routes, :discontinued, :date
  end

  def self.down
    remove_column :routes, :discontinued
  end
end
