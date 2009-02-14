require('zerenity/textinfo')

Zerenity::TextInfo(:title=>"Source file: #{$0}",:text=>File.new($0).read)

text =  Zerenity::TextInfo(:title=>"Editable Text",:editable=>true)
if text
  puts "You entered:"
  puts text
else
  puts "You clicked cancel"
end
