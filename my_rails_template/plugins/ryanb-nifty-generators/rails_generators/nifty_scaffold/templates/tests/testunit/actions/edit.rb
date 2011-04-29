  test "edit" do
    get :edit, :id => <%= class_name %>.first
    assert_template 'edit'
  end
