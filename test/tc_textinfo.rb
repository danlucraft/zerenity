require('test/unit')
require('gtk2')
require('zerenity/textinfo')

class TC_TextInfo < Test::Unit::TestCase
  def setup
    Gtk.init #Prevents segmentation fault
    @options = {}
    @dialog = Gtk::Dialog.new
  end

  def test_check_normal
    Zerenity::TextInfo.check(@options)
    assert_equal(false,@options[:editable])
    assert_equal(false,@options[:scrollable])
    assert_equal(-1,@options[:width])
    assert_equal(-1,@options[:height])
    assert_equal("",@options[:text]) 
  end

  def test_build_normal
    Zerenity::TextInfo.build(@dialog,@options)
    assert_equal(Gtk::ScrolledWindow,@dialog.vbox.children[0].class)
    assert_equal(Gtk::TextView,@dialog.vbox.children[0].children[0].class)
    assert_equal(false,@dialog.vbox.children[0].children[0].editable?)
  end

  def test_retrieve_selection
    @options[:text]="This is some\ntext" 
    Zerenity::TextInfo.build(@dialog,@options)
    assert_equal("This is some\ntext",Zerenity::TextInfo.retrieve_selection(@dialog,@options)) 
  end
end
