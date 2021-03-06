class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def normalize_friendly_id(string)
    # string.to_slug.normalize.to_s
    string.to_slug.normalize(transliterations: :russian).to_s
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.page(params[:page])
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @topic = Topic.friendly.find(params[:topic_id])
    @post = Post.new
    @topic.posts.build
    # @topic.posts.reply_to_id = 1
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @topic = Topic.friendly.find(params[:topic_id])
    @user = User.find(current_user.id)
    @post = Post.new(post_params)
    @post.topic_id = @topic.id
    @post.user_id = current_user.id
    @post.reply_to_id = 1
    count = Post.where(topic_id: @topic.id).count
    @post.reply_to_id = count if count > 1
    if !@user.count_message.nil?
      @user.count_message = @user.count_message + 1
    else
      @user.count_message = 0
      @user.count_message = @user.count_message + 1
     end
    @user.save
    # @post.reply_to_id = current_user.id
    @topic.last_id = current_user.id
    @topic.save
    respond_to do |format|
      if @post.save
        format.html { redirect_to topic_path(@topic.id), notice: 'Post was successfully created.' }
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
    @topic = Topic.friendly.find(@post.topic_id)
    @topic.slug = normalize_friendly_id(@topic.subject)
    @topic.save
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
    @post = Post.find(params[:id])
    @topic = Topic.friendly.find(@post.topic_id)
    if @post.reply_to_id = nil
      @topic.destroy
    else
      @post.destroy
    end
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
  def post_params
    params.require(:post).permit(:text, :user_id, :topic_id, :reply_to_id, posts: [:text])
  end
end
