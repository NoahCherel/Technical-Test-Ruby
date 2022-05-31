class TeamsController < ApplicationController
  include TeamsHelper
  def index
    @teams = Team.all
    @players = Player.all
  end

  def show
    @team = Team.find(params[:id])
    if @team.players.count != 11
      @text = "Please make sure that the team has 11 players."
    end
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to '/teams'
    else
      render 'new', status: 303
    end

  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(add_player_params) && @team.players.count <= 11
      redirect_to '/teams'
    else
      render 'edit', status: 303
    end
  end

  def destroy
    @team = Team.find(params[:id])
    if @team.destroy
      redirect_to '/teams', status: 303
      Team.reset_pk_sequence
    end
  end

  def create_teams
    Team.delete_all
        Player.delete_all
        Team.reset_pk_sequence
        Player.reset_pk_sequence
        team_names = ["Team 1", "Team 2", "Team 3", "Team 4", "Team 5", "Team 6", "Team 7", "Team 8"]
        team_classes = ["DPS", "Healer", "Tank"]
        team_names.each do |name|
        team = Team.new(name: name, town: Faker::Address.city)
        team.save
        end
        team_names.each do |name|
        team = Team.find_by(name: name)
        11.times do
            player = Player.new(name: Faker::Name.name, player_class: team_classes.sample, team_id: team.id)
            player.save
        end
        end
        redirect_to '/teams'
  end

def verify_battle_is_possible
  if Team.count != 8
    redirect_to '/teams', status: 303
    flash[:alert] = "There must be 8 teams."
    return
  end
  Team.all.each do |team|
    if team.players.count != 11
      redirect_to '/teams', status: 303
      flash[:alert] = "Please make sure that each team has 11 players."
      return
    end
  end
end

  def team_battle
    verify_battle_is_possible
    @teams = Team.all
    @teams.each do |team|
      team.nb_kills = 0
      team.nb_deaths = 0
      team.nb_points = 0
      team.save
    end
    @teams.each do |team|
      @teams.each do |team2|
        if team.id != team2.id
          team1_kills = rand(1..5)
          team2_kills = rand(1..5)
          if team1_kills > team2_kills
            team.nb_kills += team1_kills
            team.nb_deaths += team2_kills
            team2.nb_kills += team2_kills
            team2.nb_deaths += team1_kills
            team.nb_points += 5

            team.save
            team2.save

          elsif team2_kills > team1_kills
            team.nb_kills += team1_kills
            team.nb_deaths += team2_kills
            team2.nb_kills += team2_kills
            team2.nb_deaths += team1_kills
            team2.nb_points += 5

            team2.save
            team.save
          else
            team.nb_kills += team2_kills
            team.nb_deaths += team1_kills
            team2.nb_kills += team1_kills
            team2.nb_deaths += team2_kills
            team.nb_points += 1
            team2.nb_points += 1

            team.save
            team.save
          end
        end
      end
    end
    @teams.each do |team|
      if team.nb_points < 0
        team.nb_points = 0
        team.save
      end
    end
  end

  private
  def team_params
    params.require(:team).permit(:name, :town)
  end
  def add_player_params
    params.require(:team).permit(:name, :town, :player_id)
  end
end