require 'resque'
require 'will_paginate'
require 'will_paginate/array'

class SearchController < ApplicationController
  def search
    @blog = Blog.where(:name => params[:url])
    if(@blog.empty?)
      #If this blog does not exist in database, add and start crawling
      Resque.enqueue(HardWorker, params[:url])
      sleep(5)
      search
    end
    @blogs = Post.where(:name => /.*#{params[:url]}.*/i)
    @search = @blogs.paginate(:per_page=>10, :page => params[:page])#, :conditions =>{:name=> 'http://blog.bufferapp.com'})
    if request.xhr?
      sleep(3)
      render :partial => @search
    end
  end
end


