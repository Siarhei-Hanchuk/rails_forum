class SearchController < ApplicationController
  #skip_before_filter :is_admin
  authorize_resource :class => false
  
  def index
  	@text=params[:text]
  	@type=(params[:gender])[:contactmethod]
  	if @type=='topics'
      @arr={}
  		Topic.find(:all).each { |e|
  			@arr[e.id]=e if e.title.scan(@text)!=[]
  		}
  	end
  	if @type=='posts'
      @arr=[]
  		Post.all.each { |p|
  			@arr.push p if p.body.scan(@text)!=[]
  		}
 	  end
  end
end
