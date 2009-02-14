require('zerenity/entry')

class TC_Entry < Test::Unit::TestCase
  def setup
    Gtk.init
    @options = {:title=>"Enter your name",:text=>"Enter your name"}
    @dialog = Gtk::Dialog.new
  end

  def test_build_normal
    Zerenity::Entry.build(@dialog,@options)
    assert_equal(true,@dialog.vbox.children[1].visibility?)
  end
  
  def test_build_adds_default_string
    Zerenity::Entry.build(@dialog,@options.merge(:string => "hi"))
    assert_equal("hi", @dialog.vbox.children[1].text)
  end
  
  def test_build_password
    @options[:password] = true
    Zerenity::Entry.build(@dialog,@options)
    assert_equal(false,@dialog.vbox.children[1].visibility?)
  end

  def test_build_activates_default
    @options[:activatesDefault] = false 
    Zerenity::Entry.build(@dialog,@options)
    assert(!@dialog.vbox.children[1].activates_default?)
  end

  def test_check_normal
    Zerenity::Entry.check(@options)
    assert(!@options[:password])
    assert(@options[:activatesDefault])
    @options[:password] = true
    Zerenity::Entry.check(@options)
    assert(@options[:password])
    @options[:activatesDefault] = false
    Zerenity::Entry.check(@options)
    assert(!@options[:activatesDefault])
  end

  def test_retrieve_selection_normal
    Zerenity::Entry.build(@dialog,@options)
    @dialog.vbox.children[1].text = "Farrel"
    assert_equal("Farrel",Zerenity::Entry.retrieve_selection(@dialog,@options))
  end
end
