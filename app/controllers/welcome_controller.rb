class WelcomeController < ApplicationController
  def index
    @team_name = ENV.fetch("TEAM_NAME", "undefined")
    @my_token = ENV.fetch("MY_TOKEN", "undefined")
  end
end
