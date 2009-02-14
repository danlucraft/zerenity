require('test/unit')
require('gtk2')
require('zerenity/fileselection')

class TC_FileSelection < Test::Unit::TestCase
  def setup
    Gtk.init
    @options={}
    @dialog=Gtk::Dialog.new
  end

  def test_check_normal
    Zerenity::FileSelection.check(@options)
    assert_equal(Gtk::FileChooser::ACTION_OPEN,@options[:action])
    assert_equal("",@options[:title])
    assert_equal(false,@options[:multiple])
    assert_nil(@options[:filename])
  end

  def test_check_save
    @options[:action] = :save
    Zerenity::FileSelection.check(@options)
    assert_equal(Gtk::FileChooser::ACTION_SAVE,@options[:action])
  end

  def test_check_select_folder
    @options[:action] = :select_folder
    Zerenity::FileSelection.check(@options)
    assert_equal(Gtk::FileChooser::ACTION_SELECT_FOLDER,@options[:action])
  end

  def test_check_create_folder
    @options[:action] = :create_folder
    Zerenity::FileSelection.check(@options)
    assert_equal(Gtk::FileChooser::ACTION_CREATE_FOLDER,@options[:action])
  end
end
