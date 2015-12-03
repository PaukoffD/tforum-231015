class ToolsController < ApplicationController
#before_filter :find_forum, only: [:show, :edit, :update, :destroy]
before_action :set_topic, only: [:show, :edit, :update, :destroy]




  def index
   
    #@topics = Topic.order(:created_at).reorder('id DESC').all.page(params[:page])
    #topic=Topic.order(:created_at).reorder('id DESC').last
	#@forum = Forum.find(topic.forum_id)
	
  end
  
end