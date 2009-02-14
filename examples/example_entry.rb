require('zerenity/entry')

text = Zerenity::Entry(:text=>"Please enter your name")
puts "Hello #{text}" if text
puts "You did not enter your name" unless text

text = Zerenity::Entry(:text=>"Please enter your password",:password=>true)
puts "Your password is: #{text}" if text
puts "You did not enter your password" unless text

if (text = Zerenity::Entry(:text=>"Please enter your name. Click OK to close dialog.",:activatesDefault=>false))
  puts "Hello #{text}"
else
  puts "You did not enter your name"
end

