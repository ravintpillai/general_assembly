class AddGimphood < ActiveRecord::Migration
  def change
  	add_column :users, :gimphood, :string
  end
end
