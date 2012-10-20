require 'test/all'

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
