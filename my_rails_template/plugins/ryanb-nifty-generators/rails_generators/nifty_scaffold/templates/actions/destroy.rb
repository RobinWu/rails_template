  def destroy
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
    @<%= singular_name %>.destroy
    flash[:notice] = "#{<%= class_name %>.human_name}删除成功."
    redirect_to <%= plural_name %>_url
  end
