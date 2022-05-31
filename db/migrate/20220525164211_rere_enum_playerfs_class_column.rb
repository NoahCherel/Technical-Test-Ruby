class RereEnumPlayerfsClassColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :players, :player_class, :string, default: "DPS"
  end
end
