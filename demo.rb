require 'zenity'

puts Zenity::entry(:title => 'Enter some text', :text => 'This is a password dialog.', :arg => ['hide-text'])
puts Zenity::calendar(:title => 'Select a date')

# List
Zenity::list(title: "Example list", column: [' ', 'Column1', 'Column2'], arg: [:radiolist], list_entries: ['', 'foo', 'bar', '', 'foo2', 'bar2'])