class NiftyLayoutGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
    @name = @args.first || 'application'
  end
  
  def manifest
    record do |m|
      m.directory 'app/views/layouts'
      m.directory 'public/stylesheets'
      m.directory 'app/helpers'
      
      m.file "helper.rb", "app/helpers/layout_helper.rb"
      if options[:haml]
        m.directory 'public/stylesheets/sass'
        m.template "layout.html.haml", "app/views/layouts/#{file_name}.html.haml"
        m.file     "stylesheet.sass",  "public/stylesheets/sass/#{file_name}.sass"
      else
        m.file     "menus_config.rb", "config/initializers/menus_config.rb"
        m.file     "site_config.rb", "config/initializers/site_config.rb"
        m.template "layout.html.erb", "app/views/layouts/#{file_name}.html.erb"
        m.file     "stylesheet.css",  "public/stylesheets/#{file_name}.css"
      end
      # images
      m.file     "zh.yml", "config/locales/zh.yml"
      m.file     "blank.html.erb",  "app/views/layouts/blank.html.erb"
      m.file     "reset-fonts-grids.css",  "public/stylesheets/reset-fonts-grids.css"
      m.file     "ie_base.css",  "public/stylesheets/ie_base.css"
      m.file     "images/bottom_bg.gif", "public/images/bottom_bg.gif"
      m.file     "images/right_bg.gif", "public/images/right_bg.gif"
      m.file     "images/button-left.png", "public/images/button-left.png"
      m.file     "images/button-right.png", "public/images/button-right.png"
      m.file     "images/true.png", "public/images/true.png"
      m.file     "images/false.png", "public/images/false.png"
      m.file     "images/logo.png", "public/images/logo.png"
    end
  end
  
  def file_name
    @name.underscore
  end

  protected

    def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on("--haml", "Generate HAML for view, and SASS for stylesheet.") { |v| options[:haml] = v }
    end

    def banner
      <<-EOS
Creates generic layout, stylesheet, and helper files.

USAGE: #{$0} #{spec.name} [layout_name]
EOS
    end
end
