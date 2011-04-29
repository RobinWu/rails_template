class <%= sessions_class_name %>Controller < ApplicationController
  layout 'blank'
  skip_before_filter :login_required, :only => [:new, :create, :destroy]

  def new
  end
  
  def create
    <%= user_singular_name %> = <%= user_class_name %>.authenticate(params[:login], params[:password])
    if <%= user_singular_name %>
      session[:<%= user_singular_name %>_id] = <%= user_singular_name %>.id
      redirect_to_target_or_default(root_url)
    else
      flash.now[:error] = "用户名或密码错误."
      render :action => 'new'
    end
  end
  
  def destroy
    session[:<%= user_singular_name %>_id] = nil
    flash[:notice] = "您已退出系统."
    redirect_to login_url
  end
end
