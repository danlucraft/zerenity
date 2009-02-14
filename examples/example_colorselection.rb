require( 'zerenity/colorselection' )

color = Zerenity::ColorSelection( :title => "Choose a color" )

puts "You chose #{ color || 'nothing' }"
