  def index
    @<%= plural_name %> = <%= class_name %>.paginate(:all, :page => (params[:page] || 1), :per_page => 20)
  end
