class AddNbPoints < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :nb_points, :integer, default: 0
    add_column :teams, :nb_kills, :integer, default: 0
    add_column :teams, :nb_deaths, :integer, default: 0
  end
end
