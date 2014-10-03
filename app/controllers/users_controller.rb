class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :show, :update]

  before_action :correct_user,   only: [:edit, :update, :show]

def gruffConsole
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)
    @consoleNames = ConsoleOwnership.where(user_id: @user).joins(:consoles => :console_general).uniq.pluck("console_general.eng_name")

    g = Gruff::Spider.new(10, 800)

    @ownership = ConsoleOwnership.where(user_id: @user).joins(:consoles => :console_general)

    @consoleNames.each do |console|
      g.data console, ConsoleOwnership.where(user_id: @user).joins(:consoles => :console_general).where(:console_general => {:eng_name => console}).count
    end

    g.theme = Gruff::Themes::PASTEL
    # g.legend_font_size = 12
    
    send_data(g.to_blob, :filename => "pie.png", :type => 'image/png', :disposition=> 'inline')
  end

  def gruffBig
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)
    @consoleNames = Ownership.where(user_id: @user).joins(:games => :console_general).uniq.pluck(:eng_name)

    g = Gruff::Spider.new(30, 800)

    @ownership = Ownership.where(user_id: @user).joins(:games => :console_general)

    @consoleNames.each do |console|
      g.data console, Ownership.where(user_id: @user).joins(:games => :console_general).where(:console_general => {:eng_name => console}).count unless Ownership.where(user_id: @user).joins(:games => :console_general).where(:console_general => {:eng_name => console}).count <= 10
    end

    g.theme = Gruff::Themes::PASTEL
    # g.legend_font_size = 12
    
    send_data(g.to_blob, :filename => "pie.png", :type => 'image/png', :disposition=> 'inline')
  end

  def gruffSmall
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)
    @consoleNames = Ownership.where(user_id: @user).joins(:games => :console_general).uniq.pluck(:eng_name)

    g = Gruff::Spider.new(30, 800)
    g.title = " "

    @ownership = Ownership.where(user_id: @user).joins(:games => :console_general)

    @consoleNames.each do |console|
      g.data console, Ownership.where(user_id: @user).joins(:games => :console_general).where(:console_general => {:eng_name => console}).count unless Ownership.where(user_id: @user).joins(:games => :console_general).where(:console_general => {:eng_name => console}).count > 10
    end

    g.theme = Gruff::Themes::PASTEL
    g.legend_font_size = 12
    
    send_data(g.to_blob, :filename => "pie.png", :type => 'image/png', :disposition=> 'inline')
  end

def gruffBigAcc
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)
    @consoleNames = AccessoriesOwnership.where(user_id: @user).joins(:accessories => :console_general).uniq.pluck(:eng_name)

    g = Gruff::Spider.new(30, 800)

    @ownership = AccessoriesOwnership.where(user_id: @user).joins(:accessories => :console_general)

    @consoleNames.each do |console|
      g.data console, AccessoriesOwnership.where(user_id: @user).joins(:accessories => :console_general).where(:console_general => {:eng_name => console}).count unless Ownership.where(user_id: @user).joins(:games => :console_general).where(:console_general => {:eng_name => console}).count <= 10
    end

    g.theme = Gruff::Themes::PASTEL
    # g.legend_font_size = 12
    
    send_data(g.to_blob, :filename => "pie.png", :type => 'image/png', :disposition=> 'inline')
  end

  def gruffSmallAcc
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)
    @consoleNames = AccessoriesOwnership.where(user_id: @user).joins(:accessories => :console_general).uniq.pluck(:eng_name)

    g = Gruff::Spider.new(30, 800)
    g.title = " "

    @ownership = AccessoriesOwnership.where(user_id: @user).joins(:accessories => :console_general)

    @consoleNames.each do |console|
      g.data console, AccessoriesOwnership.where(user_id: @user).joins(:accessories => :console_general).where(:console_general => {:eng_name => console}).count unless Ownership.where(user_id: @user).joins(:games => :console_general).where(:console_general => {:eng_name => console}).count > 10
    end

    g.theme = Gruff::Themes::PASTEL
    g.legend_font_size = 12
    
    send_data(g.to_blob, :filename => "pie.png", :type => 'image/png', :disposition=> 'inline')
  end

  def show
    @user = User.find(params[:id])
    @game_count = Ownership.where(user_id: @user.id).all.count
    @console_count = ConsoleOwnership.where(user_id: @user.id).all.count
    @accessory_count = AccessoriesOwnership.where(user_id: @user.id).all.count
    
  end

  def new
    @user = User.new
  end

  def signIn
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to OOUG!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

private 

  def user_params
    params.require(:user).permit(:alias, :email, :password, :password_confirmation)
  end

# Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signIn_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to current_user, notice: "There is no " + current_user.alias + " only Zool.\nBut seriously, you can only look at your info, not someone else's"  unless current_user?(@user)
    end 
end
