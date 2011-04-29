# author Robin
# date: 2009-9-27
# sample: rails <project_name> -d mysql -m ~/scripts/rails_template/my_rails_template.rb
# links: http://m.onkey.org/2008/12/4/rails-templates
# desc: init new rails project template

# delete dirty files
run 'rm public/index.html'
run "rm public/images/rails.png"
run "rm README"
run "rm doc/README_FOR_APP"
run "rm public/favicon.ico"
run "rm public/robots.txt"

# config database
app = @root.split('/').last
file 'config/database.yml.sample', <<-END
defaults: &defaults
  adapter: mysql
  username: root
  password:
  host: localhost
  encoding: utf8
development:
  <<: *defaults
  database: #{app}_development
test:
  <<: *defaults
  database: #{app}_test
production:
  <<: *defaults
  database: #{app}_production
END
run 'cp config/database.yml.sample config/database.yml'

# config database user & password
username = ask "***Database username?"
password = ask "***Database password?"
File.open('config/database.yml','r+') do |f|
  s = f.read.gsub(/username:(.*)/,"username: #{username}")
  s = s.gsub(/password:(.*)/,"password: #{password}")
  f.rewind
  f.write s
end

# create all databases
rake 'db:create:all'

# git init
git :init

file '.gitignore', <<-CODE
log/*.log
log/*.pid
db/*.db
db/*.sqlite3
db/schema.rb
tmp
.DS_Store
doc/api
doc/app
config/database.yml
nbproject
CODE

git :add => "."
git :commit => "-a -m 'Initial Commit'"

# freeze rails
rake 'rails:freeze:gems'

# cp plugins
run "cp -Rf /home/agideo/scripts/rails_template/plugins vendor"
git :add => "."
git :commit => "-a -m 'add plugins'"

# init layout
generate(:nifty_layout)
generate(:nifty_config)
generate(:nifty_authentication)

# confit root
route 'map.root :controller => :home'

# migrate db
rake "db:migrate:reset"

git :add => "."
git :commit => "-a -m 'add layout & config & migrate'"

# init super-user
file 'db/seeds.rb', <<-CODE
User.delete_all

User.create! do |u|
  u.username = "super-admin"
  u.email = "robin.wu.cn@gmail.com"
  u.password = "123456qwerty"
  u.password_confirmation = "123456qwerty"
end
CODE
rake "db:seed"

git :add => "."
git :commit => "-a -m 'init super-admin'"
