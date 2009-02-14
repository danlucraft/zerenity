require('test/unit')
require('gtk2')
require('zerenity/info')

class TC_Info < Test::Unit::TestCase
  def setup
    Gtk.init
    @options={}
    @dialog=Gtk::Dialog.new
  end

  def test_check_normal
    Zerenity::Info.check(@options)
    assert_equal(Gtk::MessageDialog::INFO,@options[:type])
  end
end
