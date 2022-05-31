Rails.application.routes.draw do
  resources :players
  resources :teams
  root "teams#index"
  get "/create_teams" => "teams#create_teams"
  get "/team_battle" => "teams#team_battle"
end
