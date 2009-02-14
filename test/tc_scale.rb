require('test/unit')
require('gtk2')
require('zerenity/scale')

class TC_Scale < Test::Unit::TestCase
  def setup
    Gtk.init
    @options = {}
    @dialog = Gtk::Dialog.new
  end

  def test_check_normal
    assert_nothing_raised{Zerenity::Scale.check(@options)}
    assert_equal(0,@options[:initial])
    assert_equal(0,@options[:min])
    assert_equal(1,@options[:step])
    assert_equal(100,@options[:max])
  end

  def test_build_normal
    Zerenity::Scale.check(@options)
    Zerenity::Scale.build(@dialog,@options)
    assert_equal(Gtk::Label,@dialog.vbox.children[0].class)
    assert_equal(Gtk::HScale,@dialog.vbox.children[1].class)
  end

  def test_retrieve_selection_normal
    Zerenity::Scale.check(@options)
    Zerenity::Scale.build(@dialog,@options)
    @dialog.vbox.children[1].value = 20
    assert_equal(20,Zerenity::Scale.retrieve_selection(@dialog,@options))
  end
end
