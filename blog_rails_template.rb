# rails proejct-name -m http://github.com/RobinWu/rails_template/raw/master/blog_rails_template.rb
run "rm public/index.html"
generate(:scaffold, "post title:string body:text")
generate(:scaffold, "comment body:text post_id:integer")
route "map.root :controller => :posts"
rake("db:migrate")
