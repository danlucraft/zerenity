require('test/unit')
require('gtk2')
require('zerenity/warning')

class TC_Waring < Test::Unit::TestCase
  def setup
    Gtk.init
    @options={}
    @dialog = Gtk::Dialog.new
  end

  def test_build_normal
    Zerenity::Warning.check(@options)
    assert_equal(Gtk::MessageDialog::WARNING,@options[:type])
  end
end
