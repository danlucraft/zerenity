require('zerenity/base')

module Zerenity
  # Displays a text entry box. Returns the text entered or nil if 
  # Cancel is pressed.
  #
  # ====Options
  # [:password] When set to true all all characters in the text
  #             entry area will be masked by the '*' character.
  # ====Example Usage
  #  name = Zerenity::Entry(:text=>"Please enter your name.")
  def self.Entry(options={})
      Entry.run(options)
  end
  
  class Entry < Base # :nodoc:
    def self.check(options)
      super(options)
    end

    def self.build(dialog,options)
      super(dialog,options)
      dialog.vbox.add(Gtk::Label.new(options[:text],false))
      entry = Gtk::Entry.new
      entry.text = options[:string] if options[:string]
      entry.set_visibility(!options[:password])
      entry.set_activates_default(options[:activatesDefault])
      dialog.vbox.add(entry)
    end

    def self.retrieve_selection(dialog,options)
      super(dialog,options)
      dialog.vbox.children[1].text
    end
  end
end
