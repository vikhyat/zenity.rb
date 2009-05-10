require './lib/zenity'

include Zenity

puts Zenity.calendar(:title => 'Select a date')