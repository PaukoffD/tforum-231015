class ForumsController < ApplicationController
  before_action :set_forum, only: [:show, :edit, :update, :destroy]

def normalize_friendly_id(string)
    string.to_slug.normalize.to_s
end

def sitemap
  respond_to do |format|
    format.xml { render file: 'public/sitemaps/topics.xml' }
    format.html { redirect_to root_url }
  end
end


  
  
 def tools
    @categories= Category.all
    @forums = Forum.all
	#@topic=Topic.last
	#@topic= Topic.find(most_recent_post)
  end 
  
  
  
  def index
    # переписать Group.last
   if Group.last.blank?
    @group=Group.new
	@group.name="1"
	@group.save
	end
	
    @group=Group.last
    @category= Category.all
    @forums = Forum.all
	  @topic=Topic.last
	  
	#@topic= Topic.find(most_recent_post)
  end

  # GET /forums/1
  # GET /forums/1.json
  def show
  @topics = Topic.includes(:author).order(:created_at).reorder('id DESC').all.page(params[:page])
  
  end

 
  def new
    @forum = Forum.new
  end

  
  def edit
  end

 
  def create
    @forum = Forum.new(forum_params)
	@forum.slug= normalize_friendly_id(@forum.name)
  cat=Category.find(forum_params['category_id'])
  @forum.hidden=true if cat.hidden
  
    respond_to do |format|
      if @forum.save
        format.html { redirect_to @forum, notice: 'Forum was successfully created.' }
        format.json { render :show, status: :created, location: @forum }
      else
        format.html { render :new }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forums/1
  # PATCH/PUT /forums/1.json
  def update
    respond_to do |format|
      if @forum.update(forum_params)
        format.html { redirect_to @forum, notice: 'Forum was successfully updated.' }
        format.json { render :show, status: :ok, location: @forum }
      else
        format.html { render :edit }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.json
  def destroy
    @forum.destroy
    respond_to do |format|
      format.html { redirect_to forums_url, notice: 'Forum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forum
      @forum = Forum.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def forum_params
      params.require(:forum).permit(:name, :description, :slug, :category_id)
    end
end
