class ReEnumPlayersClassColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :players, :player_class, :integer, default: 0
  end
end
