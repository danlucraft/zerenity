require 'zerenity/base'

module Zerenity
  # Creates a calendar dialog allowing the user to select a date. Returns
  # a Time object representing the selected date or nil if Cancel is
  # clicked.
  #
  # ==== Example Usage
  #  date = Zerenity::Calendar(:text=>"Please select a date")
  def self.Calendar(options={})
    Calendar.run(options)
  end
 
  class Calendar < Zerenity::Base # :nodoc:
    def self.build(dialog,options)
      super(dialog,options)
      dialog.vbox.add(Gtk::Label.new(options[:text],false))
      dialog.vbox.add(Gtk::Calendar.new) 
    end

    def self.retrieve_selection(dialog,options)
      super(dialog,options)
      Time.local(*dialog.vbox.children[1].date)
    end
  end
end
