require ('test/unit')
require('test/tc_list')
require('test/tc_progress')
require('test/tc_question')
require('test/tc_textinfo')
require('test/tc_entry')
require('test/tc_base')
require('test/tc_calendar')
require('test/tc_fileselection')
require('test/tc_info')
require('test/tc_messagedialog')
require('test/tc_scale')
require('test/tc_warning')

class TS_Zerenity < Test::Unit::TestSuite
  def initialize(name="Zerenity Test Suite")
    super(name)
    @tests << TC_List.suite
    @tests << TC_Progress.suite
    @tests << TC_Question.suite
    @tests << TC_TextInfo.suite
    @tests << TC_Entry.suite
    @tests << TC_Base.suite
    @tests << TC_Calender.suite
    @tests << TC_Error.suite
    @tests << Tc_FileSelection.suite
    @tests << TC_Info.suite
    @tests << TC_MessageDialog.suite
    @tests << TC_Progress.suite
    @tests << TC_Warning.suite
    @tests << TC_Scale.suite
  end
end
