require('zerenity/progress')

Zerenity::Progress(:title=>"Normal",:text=>"Building index") do |progress|
  0.step(1,0.01) do |number|
    progress.update(number,"#{(number*100).to_i}%")
    sleep(0.02)
  end
end

Zerenity::Progress(:title=>"Normal pulse",:text=>"Querying Database")  do |progress| 
  0.step(1,0.01) do
    progress.pulse
    sleep(0.02)
  end
  progress.update(1,"Finished")
end

cancelled = Zerenity::Progress(:cancellable=>true,:text=>"Press Cancel To End Rendering",:title=>"Cancellabe") do |progress|
  while !progress.cancelled?
    progress.pulse("Processing")
    sleep(0.02)
  end
  0.step(1,0.02) do |number|
    progress.update(1.0-number,"Cleaning up")
    sleep(0.01)
  end
  progress.update(0,"Finished")
end

if cancelled 
  puts "Updating has been cancelled." 
end

Zerenity::Progress(:autoClose=>true,:text=>"Copying kernel...",:title=>"Auto close") do |progress|
  0.step(1,0.02) do |number|
    progress.update(number)
    sleep(0.03)
  end
end
  
