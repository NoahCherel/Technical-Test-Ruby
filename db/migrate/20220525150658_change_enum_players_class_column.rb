class ChangeEnumPlayersClassColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :players, :player_class, :string, default: "DPS"
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
