class PostsController < ResourceController::Base
  skip_before_filter :verify_authenticity_token

  create.wants.xml  { render :xml => @post.to_xml  }
  # TODO this is the wrong format
  destroy.wants.xml { render :xml => @post.to_xml  }
  index.wants.xml   { render :xml => @posts.to_xml }
  show.wants.xml    { render :xml => @post.to_xml  }
  update.wants.xml  { render :xml => @post.to_xml  }

  show.fails.wants.xml { render :nothing => true, :status => :not_found }

  def collection
    end_of_association_chain.find(:all, :limit => params[:per_page])
  end
end
