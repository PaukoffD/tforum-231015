class UsersController < ApplicationController
 def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    
  end
  
  def create
    
	@user = User.find(params[:topic_id])
    
	
	@user.count_message=0	
	@user.save
	
    respond_to do |format|
      if @user.save
        format.html { redirect_to topic_path(@topic.id), notice: 'User was successfully created.' }
        #format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
