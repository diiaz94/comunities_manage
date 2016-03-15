class WelcomeController < ApplicationController
  def index

  	if User.all.length > 0
  		@notUsers = false;
  	else
  		@notUsers = true;
  		puts "not User************"
  		@user = User.new
  		render "register_first", layout: "blank"

  	end

  end

  def create
  	render 'index'
  end

end
