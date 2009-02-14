require 'gtk2'

# Zerenity provides a number of simple graphical dialogs.
#
# ==== Global Options
# [:title] The text displayed in the title bar.
# [:text] The text that will be displayed in the dialog (if needed).
# [:activatesDefault] If set to false disables the firing of the OK
#                     button when the Enter key is pressed. 
module Zerenity
  CLICKED = "clicked"
  class Base # :nodoc:
    def self.check(options)
      options[:activatesDefault] = (options[:activatesDefault].nil? || options[:activatesDefault]) 
      options[:title] ||= ""
      options[:text] ||= ""
    end

    def self.build(dialog,options)
      options[:ok_button] = dialog.add_button(Gtk::Stock::OK,Gtk::Dialog::RESPONSE_OK)
      options[:cancel_button] = dialog.add_button(Gtk::Stock::CANCEL,Gtk::Dialog::RESPONSE_CANCEL)
      dialog.set_default_response(Gtk::Dialog::RESPONSE_OK) if options[:activatesDefault] 
    end
    
    def self.run(options)
      Gtk.init
      self.check(options)
      dialog = Gtk::Dialog.new(options[:title])
      self.build(dialog,options)
      result = nil
      options[:ok_button].signal_connect(CLICKED) do
        result = self.retrieve_selection(dialog,options)
        dialog.destroy
        Gtk.main_quit
      end
      options[:cancel_button].signal_connect(CLICKED) do
        dialog.destroy
        Gtk.main_quit
      end
      dialog.show_all
      Gtk.main
      return result 
    end

    def self.retrieve_selection(dialog,options)
    end
  end
end
