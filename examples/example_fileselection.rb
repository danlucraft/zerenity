require('zerenity/fileselection')

fileName = Zerenity::FileSelection(:title=>"Which file do you want?",:filename=>File.expand_path(__FILE__),:action=>:open)

puts "You chose #{fileName}" if fileName
puts "You did not select a file" unless fileName

fileNames = Zerenity::FileSelection(:title=>"Please choose the required files",:multiple=>true)

if fileNames
  puts "You chose the following files"
  fileNames.each do |fileName|
    puts "\t#{fileName}"
  end
else
  puts "You did not choose any files"
end

filename = Zerenity::FileSelection(:title=>"Save file as",:action=>:save)
filename ? puts("File saved as #{filename}") : puts("No file saved")

folder = Zerenity::FileSelection(:title=>"Select a folder",:action=>:select_folder,:multiple=>true)
folder ? puts("You selected folder #{folder}") : puts("You did not choose a folder") 

folder = Zerenity::FileSelection(:title=>"Create folder",:action=>:create_folder)
folder ? puts("Created folder #{folder}") : puts("You did not create a folder") 
