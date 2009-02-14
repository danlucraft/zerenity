require('zerenity/calendar')

date = Zerenity::Calendar(:text=>"What day is your birthday?",:title=>"Please select a date")

puts "You selected #{date.to_s}" if date
puts "You didn't select a date" unless date
