  test "show" do
    get :show, :id => <%= class_name %>.first
    assert_template 'show'
  end
