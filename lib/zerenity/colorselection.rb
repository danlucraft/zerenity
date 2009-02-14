require 'zerenity/base'

module Zerenity
  # Displays a color selection dialog. Returns the value of the color selected
  # as #rrrrggggbbbb, where r, g and b are hex digits representing the red, 
  # green and blue components respectively
  #
  #  ====Example Usage:
  #   Zereity::ColorSelection( :title => "Select a color" )
  def self.ColorSelection( options = {} )  
    ColorSelection.run( options )
  end

  class ColorSelection < Base # :nodoc:
    def self.run( options )
      self.check( options )
      Gtk.init
      color_selection = Gtk::ColorSelectionDialog.new( options[ :title ])
      result = nil
      color_selection.run do |response|
        if ( response == Gtk::Dialog::RESPONSE_OK )
          # I don't have the latest Ruby/GNOME2 on my system so this mimics current_color.to_s
          result = "##{ color_selection.colorsel.current_color.to_a.map{|channel| channel.to_s(16).rjust(4,'0').upcase }.join }"
        end
      end
      color_selection.destroy
      return result
    end
  end
end
