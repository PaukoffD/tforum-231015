class TopicsController < ApplicationController
#before_filter :find_forum, only: [:show, :edit, :update, :destroy]
before_action :set_topic, only: [:show, :edit, :update, :destroy]

def normalize_friendly_id(string)
 #string.to_slug.normalize.to_s
	string.to_slug.normalize(transliterations: :russian).to_s
end

def index
  @group=Group.last
  @category= Category.all
  @forums = Forum.all
if params[:tag]
  @topics = Topic.tagged_with(params[:tag]).page(params[:page])
else
  # @search = Topic.search(params[:q])

  @topics = Topic.order(:created_at).reorder('id DESC').all.page(params[:page])

end


  #topic=Topic.order(:created_at).reorder('id DESC').last
	 #@forum = Forum.find(topic.forum_id)

end

def top
    #count = Post.where(topic_id: @topic.id).count
    @topics = Topic.order(views_count: :DESC).all.page(params[:page])
    #topic=Topic.order(:created_at).reorder('id DESC').last
	   #@forum = Forum.find(topic.forum_id)

  end

def indextopic
  @group=Group.last
  @category= Category.all
  @forums = Forum.all
  #count = Post.where(topic_id: @topic.id).count
  @topics = Topic.order('views_count DESC').all.page(params[:page])
  #topic=Topic.order(:created_at).reorder('id DESC').last
	 #@forum = Forum.friendly.find(params[:id])

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
  @topic = Topic.friendly.find(params[:id])

  index
  render :index
    #@articles = this_blog.articles_matching(params[:q], page: params[:page], per_page: this_blog.per_page(params[:format]))
    #return error! if @articles.empty?
    #@page_title = this_blog.search_title_template.to_title(@articles, this_blog, params)
    #@description = this_blog.search_desc_template.to_title(@articles, this_blog, params)
  end





def new
  @forum = Forum.friendly.find(params[:forum_id])
  @topic = Topic.new
	@topic.posts.build
end

# GET /topics/1/edit
def edit
@topic = Topic.friendly.find(params[:id])
end


def create
 @topic = Topic.new(topic_params)

	@user = User.find(current_user.id)
	@post = Post.new
  @topic.last_post_at = Time.now
	@topic.user_id = current_user.id
	@topic.last_id = current_user.id
forum=Forum.find(topic_params['forum_id'])
@topic.hidden=true if forum.hidden

	#@topic.forum_id = params[:forum_id]
	#@post.content = params[:topic][:posts_attributes][:content]
	@post.topic_id=@topic.id
	@post.user_id = current_user.id
	#@post.save
	if (@user.count_message!=nil)
	  @user.count_message=@user.count_message+1
  else
	  @user.count_message=0
	  @user.count_message=@user.count_message+1
  end
  @user.save
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
    @topic.slug= normalize_friendly_id(@topic.subject)
	@topic.save
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
      format.html { redirect_to indextopic_path, notice: 'Topic was successfully destroyed.' }
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
	     #params.require(:user).permit!
	     #(:subject, :user_id, :last_post_at, :last_id, :forum_id, :topic_id, posts_attributes: [:id,[:user_id]], posts_attributes: [:id,[:text]] )
    end
end
