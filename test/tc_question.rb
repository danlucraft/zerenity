require('test/unit')
require('gtk2')
require('zerenity/question')

class TC_Question < Test::Unit::TestCase
  def setup
    Gtk.init
    @options = {:text=>"Do you wish to continue"}
    @dialog = Gtk::Dialog.new
  end

  def test_check
    Zerenity::Question.check(@options)
    assert_equal("Do you wish to continue",@options[:text])
    assert_equal(Gtk::MessageDialog::QUESTION,@options[:type])
  end

  def test_build_normal
    Zerenity::Question.build(@dialog,@options)
    assert_equal(Gtk::Button,@options[:cancel_button].class)
    assert(@options[:cancel_button].use_stock?)
  end
end
