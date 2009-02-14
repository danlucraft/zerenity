require 'zerenity/messagedialog'

module Zerenity
  # Displays an informational popup dialog on the screen.
  #
  # ====Examle Usage
  #  Zerenity::Info(:text=>"Processing has completed.")
  def Zerenity::Info(options={})
    Info.run(options)
  end

  class Info < MessageDialog # :nodoc: 
      def self.check(options)
        super(options)
        options[:type] = Gtk::MessageDialog::INFO
      end
  end
end
