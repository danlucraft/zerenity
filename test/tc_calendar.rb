require('test/unit')
require('gtk2')
require('zerenity/calendar')

class TC_Calender < Test::Unit::TestCase
  def setup
    Gtk.init
    @options={:text=>"Select a date"}
    @dialog=Gtk::Dialog.new
  end
  
  def test_build_normal 
    Zerenity::Calendar.build(@dialog,@options)
    assert_equal(Gtk::Label,@dialog.vbox.children[0].class)
    assert_equal("Select a date",@dialog.vbox.children[0].text)
    assert_equal(Gtk::Calendar,@dialog.vbox.children[1].class)
  end 

  def test_retrieve_selection_normal
    Zerenity::Calendar.build(@dialog,@options)
    @dialog.vbox.children[1].select_month(1,1979)
    @dialog.vbox.children[1].select_day(5)
    time = Zerenity::Calendar.retrieve_selection(@dialog,@options)
    assert_equal(5,time.day)
    assert_equal(1,time.month)
    assert_equal(1979,time.year)
  end 
end
