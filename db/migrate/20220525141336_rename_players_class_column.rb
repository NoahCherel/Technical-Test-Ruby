class RenamePlayersClassColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :players, :class, :player_class
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
