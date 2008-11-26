class PostsController < ResourceController::Base
  skip_before_filter :verify_authenticity_token

  create.wants.xml { render :xml => @post.to_xml  }
  index.wants.xml  { render :xml => @posts.to_xml }
  show.wants.xml   { render :xml => @post.to_xml  }
end
