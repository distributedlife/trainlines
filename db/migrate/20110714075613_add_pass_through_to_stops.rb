class AddPassThroughToStops < ActiveRecord::Migration
  def self.up
    add_column :stops, :pass_through, :boolean
  end

  def self.down
    remove_column :stops, :pass_through
  end
end
