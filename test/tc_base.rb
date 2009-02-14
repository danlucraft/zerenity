require('test/unit')
require('zerenity/base')

class TC_Base < Test::Unit::TestCase
  def setup
    Gtk.init
    @options={}
    @dialog=Gtk::Dialog.new
  end

  def test_check_normal
    Zerenity::Base.check(@options)
    assert(@options[:activatesDefault])
    assert_equal("",@options[:title])
    assert_equal("",@options[:text])
    @options[:activatesDefault] = false
    Zerenity::Base.check(@options)
    assert(!@options[:activatesDefault])
    @options[:activatesDefault] = "Randome object"
    Zerenity::Base.check(@options)
    assert(@options[:activatesDefault])
  end

  def test_normal_build
    Zerenity::Base.build(@dialog,@options)
    assert(@options[:ok_button].use_stock?)
    assert(@options[:cancel_button].use_stock?)
  end
end
