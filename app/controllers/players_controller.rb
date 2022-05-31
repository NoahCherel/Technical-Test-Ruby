class PlayersController < ApplicationController
    def index
        @players = Player.all
    end
    
    def show
        @player = Player.find(params[:id])
    end
    
    def new
        @player = Player.new
    end

    def create
        @player = Player.new(player_params)
        if @player.save
        redirect_to '/teams'
        else
        render 'new', status: 303
        end
    end

    def edit
        @player = Player.find(params[:id])
    end
    
    def update
        @player = Player.find(params[:id])
        @team = Team.find(player_params[:team_id])
        if @team.players.count < 11
            if @player.update(player_params)
                redirect_to '/teams'
            else
                render 'edit', status: 303
            end
        else
            @text = "The Team you selected already has 11 players, Please select another team."
            render 'edit', status: 303
        end
    end
    
    def destroy
        @player = Player.find(params[:id])
        if @player.destroy
        redirect_to '/teams', status: 303
        end
    end

    private
    def player_params
        params.require(:player).permit(:name, :player_class, :team_id)
    end
end