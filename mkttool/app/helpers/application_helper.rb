module ApplicationHelper
  def pageless(total_pages, url=nil, container=nil)
    opts = {
      :totalPages => total_pages,
      :url        => url+"?url="+params[:url],
      :loaderMsg  => 'Loading more results',
      :loaderImage => image_path("load.gif")
    }
    
    container && opts[:container] ||= container
    
    javascript_tag("$('#posts').pageless(#{opts.to_json});")
  end
  
  def set_url(url)
    $URL = url
  end
  
  def get_url()
    return $URL
  end
end
