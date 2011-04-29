  test "index" do
    get :index
    assert_template 'index'
  end
