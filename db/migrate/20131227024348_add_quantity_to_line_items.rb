class AddQuantityToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :quatity, :integer, default: 1 
  end
end
