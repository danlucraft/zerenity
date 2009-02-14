require('zerenity/base')

module Zerenity
  # Displays text in a multiline text info box. 
  #
  # ====Options
  # [:editable] If set to true the text info box is editable.
  # [:scrollable] If the size of the text does not fit in the 
  #               height and width constraints, the text info box will become
  #               scrollable
  # [:height,:width] The height and width of the text box, in pixels. 
  #                  Note this is not the height and weidth of the full window.
  # [:text] The text to be displayed in the text info box.
  #
  # ====Example Usage
  #  Zerenity::TextIfno(:text=>File.new($0).read)
  def self.TextInfo(options={})
    TextInfo.run(options)
  end

  class TextInfo < Base # :nodoc: 
    def self.check(options)
      super(options)
      options[:editable] ||= false
      options[:scrollable] ||= false
      options[:height] ||= -1
      options[:width] ||= -1
      options[:text] ||= ""
    end

    def self.build(dialog,options)
      super(dialog,options)
      textView = Gtk::TextView.new
      textView.set_size_request(options[:width].to_i,options[:height].to_i) 
      textView.buffer.text = options[:text].to_s
      textView.editable = options[:editable]
      scrolledWindow = Gtk::ScrolledWindow.new
      scrolledWindow.hscrollbar_policy = options[:scrollable] ? Gtk::POLICY_AUTOMATIC : Gtk::POLICY_NEVER
      scrolledWindow.vscrollbar_policy = options[:scrollable] ? Gtk::POLICY_AUTOMATIC : Gtk::POLICY_NEVER 
      scrolledWindow.add(textView)
      dialog.vbox.add(scrolledWindow)
    end

    def self.retrieve_selection(dialog,options)
      super(dialog,options)
      return dialog.vbox.children[0].children[0].buffer.text
    end
  end
end
