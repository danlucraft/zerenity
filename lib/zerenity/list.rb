require('zerenity/base')

module Zerenity
  # Displays a list dialog on the screen. Items in the list
  # can be selected. Returns the rows which were selected 
  # or nil if Cancel is clicked.
  #
  # ====Options
  # [:columns] The names which will be displayed at the top og
  #             each column. This option is mandatory.
  # [:data] The data for the list,  with each row
  #         being another array.
  # [:radiolist] If this is set true the first column of the 
  #              list will be rendered as a radiobutton. The first element
  #              of every data array should either be a true or false.
  # [:checklist] If this is set true the first column of the 
  #              list will be rendered as a checkbox. The first element
  #              of every data array should either be a true or false.
  #              When this is set mutiple rows can be selected and an 
  #              array of selected rows are returned.
  # *Note* :radiolist and :checklist are mutually exclusive. If 
  # both are set true an exception is thrown. An exception
  # is also thrown if the data rows are not equal length or 
  # they differ in length with the number of columns.
  #
  # ====Example Usage
  #  choice = Zerenity::List(:columns=>["Food","Energy"],:data=>[["Chips","200KJ"],["Chocolate","300KJ"]])
  def self.List(options={})
    List.run(options)
  end

  class List < Base # :nodoc:
    def self.check(options)
      super(options)
      raise(ArgumentError.new("No column data was given")) unless options[:data]      
      raise(ArgumentError.new("No column headers were given")) unless  options[:columns]
      raise(ArgumentError.new("Column headers and column data differ in length")) unless  options[:columns].length.eql?(options[:data][0].length)
      raise(ArgumentError.new("Column data lengths are not equal")) unless  options[:data].map{|element|element.length}.uniq.length.eql?(1)
      raise(ArgumentError.new("Radiolist and checklist options can not both be set")) if (options[:radiolist] && options[:checklist]) 
    end

    def self.build(dialog,options)
      super(dialog,options)
      columnTypes = Array.new(options[:columns].length){String}
      (options[:radiolist] || options[:checklist]) ? columnTypes[0] = TrueClass : nil
      listStore = Gtk::ListStore.new(*columnTypes)
      options[:data].each do |datarow|
        row = listStore.append
        datarow.each_with_index do |value,index|
          row[index] = value
        end
      end
      treeView = Gtk::TreeView.new(listStore)
      treeView.selection.mode = (options[:checklist] ? Gtk::SELECTION_MULTIPLE : Gtk::SELECTION_SINGLE)
      toggleProc = (if (treeView.selection.mode.eql?(Gtk::SELECTION_SINGLE))
                    lambda do |cell,path|
                      selectedRow = treeView.model.get_iter(path)
                      if !selectedRow[0]
                        selectedRow[0] = true 
                        currentRow = treeView.model.iter_first
                        begin
                          currentRow[0] = false unless selectedRow == currentRow
                        end while (currentRow.next!)
                      end
                    end
    else
      lambda do |cell,path|
        selectedRow = treeView.model.get_iter(path)
        selectedRow[0] = !selectedRow[0]
      end
    end)
    options[:columns].each_with_index do |columnName,index|
      renderer,column =  columnTypes[index].eql?(TrueClass) ? [Gtk::CellRendererToggle.new,:active] : [Gtk::CellRendererText.new,:text]
      if index.eql?(0)
        renderer.signal_connect('toggled',&toggleProc) if renderer.class.eql?(Gtk::CellRendererToggle)
        renderer.set_radio(true) if options[:radiolist]
      end
      treeView.append_column(Gtk::TreeViewColumn.new(columnName,renderer,column=>index))
    end
    dialog.vbox.add(treeView)
  end

  def self.retrieve_selection(dialog,options)
    super(dialog,options)
    treeView = dialog.vbox.children[0]
    results = []
    if (options[:checklist])
      treeView.model.each do |model,path,selectedRow|
        if selectedRow[0]
          resultRow = []
          (model.n_columns-1).times {|index| resultRow << selectedRow[index+1]}
          results << resultRow
        end
      end
      return nil if results.size.zero?
    elsif(options[:radiolist])
      treeView.model.each do |model,path,selectedRow|
        if selectedRow[0]
          (model.n_columns-1).times{|index| results << selectedRow[index+1]}
          break
        end
      end
    else
      selectedRow = treeView.selection.selected
      treeView.model.n_columns.times{|index| results << selectedRow[index]}
    end
    return results
  end
end
end
