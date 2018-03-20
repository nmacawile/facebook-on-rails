module PostsHelper
	
  def link_to_next_page
    page = params[:page].to_i == 0 ? 1 : params[:page].to_i
	  next_page = page + 1
	  
    if @posts.next_page
      link_to "Load more",
              request.path << "?page=#{next_page}",
              remote: true,
              class: ["btn",
                      "btn-default",
                      "btn-block",
                      "load-more"]
    end
  end
end
