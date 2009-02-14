require('test/unit')
require('gtk2')
require('zerenity/messagedialog')

class TC_MessageDialog < Test::Unit::TestCase
  def setup
    Gtk.init
    @options={}
    @dialog = Gtk::Dialog.new
  end

  def test_build_normal
    Zerenity::MessageDialog.build(@dialog,@options)
    assert_nil(@options[:cancel_button])
  end
end
