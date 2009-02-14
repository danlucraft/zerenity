require 'zerenity/messagedialog'

module Zerenity
  # Displays an error dialog.
  # ====Example Usage
  #  Zerenity::Error(:text=>"An error has occured. Please check the system log.")
  def self.Error(options={})
    Error.run(options)
  end

  class Error < MessageDialog # :nodoc: 
      def self.check(options)
        super(options)
        options[:type] = Gtk::MessageDialog::ERROR  
      end
  end
end
