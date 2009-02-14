require('zerenity/base')

module Zerenity
  # Displays a sliding scale. Returns the value selected or nil if
  # cancel is pressed.
  #
  # ====Options
  # [:min] The minimum value of the sliding scale. Defaults to 0.
  # [:max] The maximum value of the sliding scale. Defaults to 100.
  # [:step] The size of the value increment of the sliding scale for keyboard shortcuts. Defaults to 1.
  # [:initial] The initial value of the sliding scale. Defaults to 0.
  # ====Example Usage
  #  value = Zerenity::Scale(:text=>"Please select a value", :min => 1, :max => 250, :step => 3)
  def self.Scale(options={})
    Scale.run(options)
  end

  class Scale < Zerenity::Base # :nodoc:
    def self.check(options)
      super(options)
      options[:initial] ||= 0.0
      options[:min] ||= 0.0
      options[:max] ||= 100.0
      options[:step] ||= 1.0
    end

    def self.build(dialog,options)
      super(dialog,options)
      label = Gtk::Label.new(options[:text])
      hscale = Gtk::HScale.new(options[:min],options[:max],options[:step])
      hscale.value = options[:initial].to_f
      dialog.vbox.add(label)
      dialog.vbox.add(hscale)
    end

    def self.retrieve_selection(dialog,options)
      super(dialog,options)
      dialog.vbox.children[1].value.to_i
    end
  end
end
