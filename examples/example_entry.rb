require('zerenity/entry')

name = Zerenity::Entry(:text=>"Please enter your name", :ok_button => "Go!", :cancel_button => "Forget it")
puts "Hello #{name}" if name
puts "You did not enter your name" unless name

text = Zerenity::Entry(:text=>"Please enter your password",:password=>true)
puts "Your password is: #{text}" if text
puts "You did not enter your password" unless text

if (text = Zerenity::Entry(:text=>"Please enter your name. Click OK to close dialog.",:activatesDefault=>false, :string => name))
  puts "Hello #{text}"
else
  puts "You did not enter your name"
end

