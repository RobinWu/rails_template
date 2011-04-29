# author Robin
# date: 2010-10-26
# sample: rails new <project_name> -d mysql -m ~/scripts/rails_template/rails3.rb
# desc: init new rails 3 project template

# delete dirty files
run 'rm public/index.html'
run "rm public/images/rails.png"
run "rm README"
run "rm doc/README_FOR_APP"
run "rm public/favicon.ico"
run "rm public/robots.txt"

# config database
app = app_name
file 'config/database.yml.sample', <<-END
defaults: &defaults
  adapter: mysql
  username: root
  password:
  host: localhost
  encoding: utf8
development:
  <<: *defaults
  database: #{app}_dev
test:
  <<: *defaults
  database: #{app}_test
production:
  <<: *defaults
  database: #{app}_pdt
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
# rake 'rails:freeze:gems'

# confit root
route 'map.root :controller => :home'

# migrate db
rake "db:migrate:reset"

git :add => "."
git :commit => "-a -m 'init'"

