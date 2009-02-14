require('zerenity/question')

choice = Zerenity::Question(:text=>"Process images?")
choice ? (puts "OK") : (puts "CANCEL")
