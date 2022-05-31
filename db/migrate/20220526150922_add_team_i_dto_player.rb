class AddTeamIDtoPlayer < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :team_id, :string
  end
end
