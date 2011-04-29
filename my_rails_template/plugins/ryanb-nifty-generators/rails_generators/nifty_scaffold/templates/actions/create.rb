  def create
    @<%= singular_name %> = <%= class_name %>.new(params[:<%= singular_name %>])
    if @<%= singular_name %>.save
      flash[:notice] = "#{<%= class_name %>.human_name}创建成功."
      redirect_to <%= item_path('url') %>
    else
      render :action => 'new'
    end
  end
