require 'zerenity/messagedialog'

module Zerenity
  # Displays a warning dialog on the screen.
  #
  # ====Example Usage
  #  Zerenity::Warning(:text=>"This operation can cause data corruption if interrupted")
  def self.Warning(options={})
    Warning.run(options)
  end
  
  class Warning < MessageDialog # :nodoc: 
      def self.check(options)
        super(options)
        options[:type] = Gtk::MessageDialog::WARNING  
      end
  end
end
