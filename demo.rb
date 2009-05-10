require 'lib/zenity'

puts Zenity::entry(:title => 'Enter some text', :text => 'This is a password dialog.', :arg => ['hide-text'])
puts Zenity::calendar(:title => 'Select a date')