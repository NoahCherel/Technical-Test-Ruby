class RereEnumPlayersClassColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :players, :player_class, :string
  end
end
