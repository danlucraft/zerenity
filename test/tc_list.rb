require('test/unit')
require('gtk2')
require('zerenity/list')

class TC_List < Test::Unit::TestCase
  def setup
    Gtk.init
    @options = {:columns=>["Snack","Energy(KJ)"],:data=>[["Beer","300"],["Chips","500"],["Chocolate","750"]]}
    @dialog = Gtk::Dialog.new
  end

  def test_check_normal
    assert_nothing_raised{Zerenity::List.check(@options)}
  end
  
  def test_check_no_options
    assert_raise(ArgumentError,""){Zerenity::List.check}
  end

  def test_check_no_data
    @options[:data] = nil
    assert_raise(ArgumentError,"Column data not set but no error raised"){Zerenity::List.check(@options)}
  end

  def test_check_no_columns
    @options[:columns] = nil
    assert_raise(ArgumentError,"Column headers not set but no error raised"){Zerenity::List.check(@options)}
  end

  def test_check_different_columns_data_length
    @options[:columns] << "Fat"
    assert_raise(ArgumentError,"Columns length greater than data but no error raised"){Zerenity::List.check(@options)}
  end

  def test_check_different_data_length
    @options[:data][1] << "100"
    assert_raise(ArgumentError,"Data lengths differ but no error was raised"){Zerenity::List.check(@options)}
  end

  def test_check_both_radiolist_checklist
    @options[:checklist]  = true
    @options[:radiolist] = true
    assert_raise(ArgumentError,"Radio and checkist options set but no error was raised"){Zerenity::List.check(@options)}
  end

  def test_build_normal
    Zerenity::List.build(@dialog,@options)
    treeView = @dialog.vbox.children[0]
    assert_equal(Gtk::ListStore,treeView.model.class,"TreeView model class is not ListStore")
    assert_equal(2,treeView.model.n_columns)
    assert_equal(String,treeView.model.get_column_type(0))
    assert_equal(String,treeView.model.get_column_type(1))
    row = treeView.model.iter_first
    @options[:data].each do |datarow|
      datarow.each_with_index do |value,index|
        assert_equal(value,row[index])
      end
      row.next!
    end
    assert_equal(@options[:columns].size,treeView.columns.size)
  end

  def test_retrieve_selection_normal
   Zerenity::List.build(@dialog,@options)
   treeView = @dialog.vbox.children[0]
   treeView.selection.select_iter(treeView.model.iter_first)
   selection = Zerenity::List.retrieve_selection(@dialog,@options)
   assert_equal(@options[:data][0][0],selection[0])
   assert_equal(@options[:data][0][1],selection[1])
  end

  def test_build_radio
    @options[:columns] = Array("Selected").concat(@options[:columns])
    @options[:data][0] = Array(true).concat(@options[:data][0]) 
    @options[:data][1] = Array(false).concat(@options[:data][1])
    @options[:data][2] = Array(false).concat(@options[:data][2])
    @options[:radiolist] = true
    Zerenity::List.build(@dialog,@options)
    treeView = @dialog.vbox.children[0]
    assert_equal(3,treeView.model.n_columns)
    assert_equal(TrueClass,treeView.model.get_column_type(0))
    assert_equal(String,treeView.model.get_column_type(1))
    assert_equal(String,treeView.model.get_column_type(2))
    row = treeView.model.iter_first
    @options[:data].each do |datarow|
      datarow.each_with_index do |value,index|
        assert_equal(value,row[index])
      end
      row.next!
    end
    assert_equal(@options[:columns].size,treeView.columns.size)
  end

  def test_retrieve_selection_radio
    @options[:columns] = Array("Selected").concat(@options[:columns])
    @options[:data][0] = Array(true).concat(@options[:data][0]) 
    @options[:data][1] = Array(false).concat(@options[:data][1])
    @options[:data][2] = Array(false).concat(@options[:data][2])
    @options[:radiolist] = true
    Zerenity::List.build(@dialog,@options)
    selected = Zerenity::List.retrieve_selection(@dialog,@options)
    assert_equal(@options[:data][0][1..2],selected)
  end

  def test_build_checklist
    @options[:columns] = Array("Selected").concat(@options[:columns])
    @options[:data][0] = Array(true).concat(@options[:data][0]) 
    @options[:data][1] = Array(true).concat(@options[:data][1])
    @options[:data][2] = Array(false).concat(@options[:data][2])
    @options[:checklist] = true
    Zerenity::List.build(@dialog,@options)
    treeView = @dialog.vbox.children[0]
    assert_equal(3,treeView.model.n_columns)
    assert_equal(TrueClass,treeView.model.get_column_type(0))
    assert_equal(String,treeView.model.get_column_type(1))
    assert_equal(String,treeView.model.get_column_type(2))
    row = treeView.model.iter_first
    @options[:data].each do |datarow|
      datarow.each_with_index do |value,index|
        assert_equal(value,row[index])
      end
      row.next!
    end
    assert_equal(@options[:columns].size,treeView.columns.size)
  end

  def test_retrieve_selection_cheklist
    @options[:columns] = Array("Selected").concat(@options[:columns])
    @options[:data][0] = Array(true).concat(@options[:data][0]) 
    @options[:data][1] = Array(true).concat(@options[:data][1])
    @options[:data][2] = Array(false).concat(@options[:data][2])
    @options[:checklist] = true
    Zerenity::List.build(@dialog,@options)
    selected = Zerenity::List.retrieve_selection(@dialog,@options)
    assert_equal(@options[:data][0][1..2],selected[0])
    assert_equal(@options[:data][1][1..2],selected[1])
  end
end
