# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
  def show_title?
    @show_title
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args.map(&:to_s)) }
  end
  
  def javascript(*args)
    args = args.map { |arg| arg == :defaults ? arg : arg.to_s }
    content_for(:head) { javascript_include_tag(*args) }
  end

  def simple_paginate(records, options = {})
    will_paginate(records, {:previous_label => '上一页', :next_label => '下一页'}.merge(options))
  end
  
  # for example
=begin  
    <<-js
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));

try {
var pageTracker = _gat._getTracker("UA-7857919-1");
pageTracker._trackPageview();
} catch(err) {}
    js
=end
  def google_analytics_js
    <<-js
    js
 	end

  def curr_menu?(item)
    curr_menu ||= nil
    (item[:curr_conditions] || {}).each do |k, v|
      curr_menu ||= true
      curr_menu = (curr_menu && (v.is_a?(Array) ? v.include?(params[k]) : v == params[k]))
      break unless curr_menu
    end
    curr_menu
  end
end
