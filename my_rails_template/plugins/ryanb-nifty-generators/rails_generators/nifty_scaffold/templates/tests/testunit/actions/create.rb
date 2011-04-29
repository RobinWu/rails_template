  test "create invalid" do
    <%= class_name %>.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  test "create valid" do
    <%= class_name %>.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to <%= item_path_for_test('url') %>
  end
