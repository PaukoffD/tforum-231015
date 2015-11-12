class TopicsController < ApplicationController
#before_filter :find_forum, only: [:show, :edit, :update, :destroy]
before_action :set_topic, only: [:show, :edit, :update, :destroy]


def normalize_friendly_id(string)
    string.to_slug.normalize.to_s
end 

  def index
   
    @topics = Topic.order(:created_at).reorder('id DESC').all.page(params[:page])
    #topic=Topic.order(:created_at).reorder('id DESC').last
	#@forum = Forum.find(topic.forum_id)
	#@post = Post.find_by topic_id: topic.id
	#return forum
  end

 
  def show
  # @user = User.find(params[:id])
   @topic = Topic.friendly.find(params[:id])
   #@topic.posts.includes()
   #@post = Post.includes(:user).find_by(topic_id: @topic.id)
   #@user = User.find_by id:  @topic.user_id
   @topic.views_count=@topic.views_count+1
   @topic.save
  end

  def search
    #@articles = this_blog.articles_matching(params[:q], page: params[:page], per_page: this_blog.per_page(params[:format]))
    #return error! if @articles.empty?
    #@page_title = this_blog.search_title_template.to_title(@articles, this_blog, params)
    #@description = this_blog.search_desc_template.to_title(@articles, this_blog, params)
    #respond_to do |format|
    #  format.html { render 'search' }
     # format.rss { render 'index_rss_feed', layout: false }
     # format.atom { render 'index_atom_feed', layout: false }
    end
  
  
  
  
  
  def new
    @forum = Forum.friendly.find(params[:forum_id])
    @topic = Topic.new
	puts @forum.id
	@topic.posts.build
  end

  # GET /topics/1/edit
  def edit
  @topic = Topic.friendly.find(params[:id])
  end

  
  def create
 @topic = Topic.new(topic_params)

	#topic_params.merge
	# if @topic.save
    #@topic = Topic.new(:name => params[:topic][:name], :last_post_at => Time.now, :forum_id => params[:topic][:forum_id])
 
    #if @post.save
   #   flash[:notice] = "Successfully created topic."
    # redirect_to forum_topics_path(:forum_id)
    #else
   #   redirect :action => 'new'
   # end
  #else
   # render :action => 'new'
  #end
	
	
	
	
	@post = Post.new 
    @topic.last_post_at = Time.now
	
	@topic.user_id = current_user.id
	@topic.last_id = current_user.id
	#@topic.forum_id = params[:forum_id]
	puts @topic.forum_id
	#@post.content = params[:topic][:posts_attributes][:content]
	@post.topic_id=@topic.id
	@post.user_id = current_user.id
	#@post.save
	
	
	puts params[posts_attributes: [:user_id,[:user_id]]]
	puts params[posts_attributes: [:id,[:text]]]
	
	@topic.slug= normalize_friendly_id(@topic.subject)
	@topic.save
    respond_to do |format|
    #  if @topic.save
        format.html { redirect_to topic_path(@topic.id), notice: 'Topic was successfully created.' }
       
      #else
      #  format.html { render :new }
       
      end
    end


  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit!
	  #(:subject, :user_id, :last_post_at, :last_id, :forum_id, :topic_id, posts_attributes: [:id,[:user_id]], posts_attributes: [:id,[:text]] )
    end
end
