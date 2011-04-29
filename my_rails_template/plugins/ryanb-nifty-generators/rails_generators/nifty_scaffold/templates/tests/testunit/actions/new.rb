  test "new" do
    get :new
    assert_template 'new'
  end
