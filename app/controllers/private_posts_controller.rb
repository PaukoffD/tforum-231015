class PrivatePostsController < ApplicationController
  # before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = PrivatePost.all.order(:created_at).reorder('id DESC').page(params[:page])
    # PrivatePost.order(:created_at).reorder('id DESC')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = PrivatePost.find((params[:id]))
    @user = User.find(params[:user_id])
    unless @post.notified
      @user.private = @user.private - 1
      puts @user.private
      @post.notified = true
    end
    @user.save
    @post.save
  end

  def search
    @user = User.find(params[:user_id])
    @post = PrivatePost.new
 end

  # GET /posts/new
  def new
    @user = User.find(params[:user_id])
    @post = PrivatePost.new
    # @posts.build
    # @topic.posts.reply_to_id = 1
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = PrivatePost.new

    @post.user_id = current_user.id
    @post.user_id_sent = params[:user_id]
    @user = User.find(params[:user_id])
    @user.private = @user.private + 1
    @user.save
    # @post.reply_to_id = 1
    # count = Post.where(topic_id: @topic.id).count
    # if count>1
    # @post.reply_to_id = count
    # end

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
        # format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to topic_path(@post.topic_id), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    # @topic = Topic.find(params[:topic_id])
    # s=@topic.id
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def private_post_params
    params.require(:private_post).permit(:text, :user_id, :topic, :user_id_sent)
    params.require(:user).!permit
  end
end
