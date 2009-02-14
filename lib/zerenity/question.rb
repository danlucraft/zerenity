require('zerenity/messagedialog')

module Zerenity
  # Displays a question dialog. Returns true if OK is clicked, false if 
  # Cancel is clicked.
  #
  # ====Example Useage
  #  if Zerenity::Question(:text=>"Continue processing?")
  #    post_process_files()
  #  end
  def self.Question(options={})
    Question.run(options)
  end

  class Question < MessageDialog # :nodoc:
    def self.check(options)
      super(options)
      options[:type] = Gtk::MessageDialog::QUESTION
    end

    def self.build(dialog,options)
      super(dialog,options)
      options[:cancel_button] = dialog.add_button(Gtk::Stock::CANCEL,Gtk::Dialog::RESPONSE_CANCEL)
    end
  end
end
