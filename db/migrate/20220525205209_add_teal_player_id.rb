class AddTealPlayerId < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :player_id, :string
  end
end
