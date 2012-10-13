class SearchController < ApplicationController
  def index
  	@text=params[:text]
  	@type=(params[:gender])[:contactmethod]
  	@arr={}
  	if @type=='topics'
  		Topic.find(:all).each { |e|
  			@arr[e.id]=e.title if e.title.scan(@text)!=[]
  		}
  	end
#  	if @type=='posts'
#  		Post.all.each { |p|
#  			@arr.push p.body if 
#  		}
  	#end
  end
end
