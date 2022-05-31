module TeamsHelper
    def create_8_teams
        Team.delete_all
        Player.delete_all
        Team.reset_pk_sequence
        Player.reset_pk_sequence
        team_names = ["Team 1", "Team 2", "Team 3", "Team 4", "Team 5", "Team 6", "Team 7", "Team 8"]
        team_towns = ["Town 1", "Town 2", "Town 3", "Town 4", "Town 5", "Town 6", "Town 7", "Town 8"]
        team_classes = ["DPS", "Healer", "Tank"]
        team_names.each do |name|
        team = Team.new(name: name, town: team_towns.sample)
        team.save
        end
        team_names.each do |name|
        team = Team.find_by(name: name)
        11.times do
            player = Player.new(name: Faker::Name.name, player_class: team_classes.sample, team_id: team.id)
            player.save
        end
        end
    end
end
