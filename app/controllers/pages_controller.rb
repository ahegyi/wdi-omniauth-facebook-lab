class PagesController < ApplicationController
  before_filter :authenticate_user!, :only => [:friends]

  def index
    if user_signed_in?
      @current_user = current_user
    end
  end

  def friends
    @current_user = current_user
    @graph = Koala::Facebook::API.new(@current_user.oauth_token)
    #@friends = @graph.get_connections("me", "friends", :fields => "picture,name,birthday,hometown,location")[0..20]
    friend_count = params[:friend_count].to_i
    @friends = @graph.get_connections("me", "friends?fields=picture,name,link")[0...friend_count]
  end
end
