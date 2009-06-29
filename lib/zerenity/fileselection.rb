require 'zerenity/base'

module Zerenity
  # Displays a file/directory selection dialog. Returns the name(s)
  # of the files/directories chosen or nil if Cancel is pressed.
  #
  # ====Options
  # [:filename] The file to selected initially
  # [:multiple] If set to true multiple files/directories can be selected 
  #             and an array of file/directory names will be returned.
  # [:action] The default behavour is to select a file but this can be 
  #           overridden by setting the action key to one of the following values: 
  #           [:save] Save a file 
  #           [:select_folder] Select a folder
  #           [:create_folder] Create a folder - note this will actually create
  #                            the directory.
  #
  # ====Example Usage:
  #  Zerenity::FileSelection(:title=>"Select a directory", :action=>:select_folder)
  def self.FileSelection(options={})
    FileSelection.run(options)
  end

  class FileSelection < Base # :nodoc:
    def self.check(options)
      super(options)
      options[:action] = (case options[:action]
      when :save
        Gtk::FileChooser::ACTION_SAVE
      when :select_folder
        Gtk::FileChooser::ACTION_SELECT_FOLDER
      when :create_folder
        Gtk::FileChooser::ACTION_CREATE_FOLDER
      else
        Gtk::FileChooser::ACTION_OPEN
      end)
      options[:title] ||= ""
      options[:filename] ||= nil
      options[:multiple] ||= false
    end
    
    def self.run(options)
      self.check(options)
      Gtk.init
      fileSelection = Gtk::FileChooserDialog.new(
        options[:title],
        nil,
        options[:action],
        nil,
        [Gtk::Stock::CANCEL,Gtk::Dialog::RESPONSE_CANCEL],
        [Gtk::Stock::OK,Gtk::Dialog::RESPONSE_OK])
      fileSelection.set_filename(options[:filename]) if options[:filename]
      fileSelection.set_select_multiple(true) if options[:multiple]
      result = nil 
      fileSelection.run do |response|
        if (response == Gtk::Dialog::RESPONSE_OK)
          if options[:multiple] 
            result = fileSelection.filenames
          else
             result = fileSelection.filename
          end
        end
      end
      fileSelection.destroy
      return result
    end
  end
end
