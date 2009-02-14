require('test/unit')
require('zerenity/progress')

class TC_Progress < Test::Unit::TestCase
  def setup
    Gtk.init
    @options = {:title=>"Operation in progress",:text=>"Building index..."}
    @dialog = Gtk::Dialog.new
    @hButtonBox = Gtk::HButtonBox.new
    @hButtonBox.add(Gtk::Button.new)
    @hButtonBox.add(Gtk::Button.new)
    @progressProxy = Zerenity::ProgressProxy.new
  end

  def test_build_normal
    Zerenity::Progress.build(@dialog,@options,@progressProxy)
    assert_equal(Gtk::ProgressBar,@dialog.vbox.children[1].class)
    assert_equal(@options[:text],@dialog.vbox.children[0].text)
  end

  def test_check_normal
    Zerenity::Progress.check(@options)
    assert(!@options[:autoClose])
    assert(!@options[:cancellable])
  end

  def test_check_options
    @options[:autoClose]=true
    @options[:cancellable]=true
    Zerenity::Progress.check(@options)
    assert(@options[:autoClose])
    assert(@options[:cancellable])
  end
end

class TC_ProgressProxy < Test::Unit::TestCase
  def setup
    Gtk.init
    @progressBar = Gtk::ProgressBar.new
    @progress= Zerenity::ProgressProxy.new
    @progress.progressBar = @progressBar
  end

  def test_update
    @progress.update(0.10,"10%")
    assert_equal(0.10,@progressBar.fraction)
    assert_equal("10%",@progressBar.text)
    @progress.update(0.15)
    assert_equal(0.15,@progressBar.fraction)
    assert_raise(ArgumentError){@progress.update}
  end

  def test_pulse
    @progress.pulse
    assert(@progressBar.pulse)
    assert_nil(@progressBar.text)
    @progress.pulse("Compiling")
    assert(@progressBar.pulse)
    assert_equal("Compiling",@progressBar.text)
  end

  def test_text
    @progress.text="Compiling"
    assert_equal("Compiling",@progressBar.text)
  end

  def test_percentage
    @progress.percentage=0.5
    assert_equal(0.5,@progressBar.fraction)
  end

  def test_cancelled
    @progress.cancel!
    assert_equal(true,@progress.cancelled?)
  end
end
