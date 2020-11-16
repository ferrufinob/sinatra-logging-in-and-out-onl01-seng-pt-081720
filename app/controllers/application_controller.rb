require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    #find user in database based on their username
    # user = User.find_by(:username => params[:username])
    #if match, session[user_id] = user_id
    #redirect to /account
    #use erb to display users data on page
    #if no match, render the error page
    user = User.find_by(username: params["username"], password: params["password"])
    if user
    session[:user_id] = user.id
     
      redirect to '/account'
    else 
      erb :error
    end
  end

  get '/account' do
    erb :account
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end


end

