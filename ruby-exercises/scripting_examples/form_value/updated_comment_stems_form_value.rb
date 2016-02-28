require_relative '../script_init'

main_title 'Create Form Values'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    # fv_orig = FormValue.all_of(:model_name => "Breakout", :attribute_name => "notes").first
    # if fv_orig
    #   fv_orig.delete
    # end

    # puts "\n---------------------------------\n\n"
    # puts "Creating Non-Aligned Stems Form Values..."

    # fv_orig = FormValue.all_of(:model_name => "Breakout", :attribute_name => "non-aligned-stems").first
    # if fv_orig
    #   fv_orig.delete
    # end


    # notes_options = []
    # notes_options << ["Select Appropriate Stem", ""]
    # notes_options << ["Citation(s) Lacking the Cognitive Demand -------------------------------------------------------------", ""]
    # notes_options << ["The citation listed in the Non-Aligned Citations column is not aligned to this standard because the material...", "The citation listed in the Non-Aligned Citations column is not aligned to this standard because the material does not require students to [...]"]
    # notes_options << ["The citations listed in the Non-Aligned Citations column are not aligned to this standard because the material...", "The citations listed in the Non-Aligned Citations column are not aligned to this standard because the material does not require students to [...]"]
    # notes_options << ["Citation(s) Lacking Content and/or Context -------------------------------------------------------------", ""]
    # notes_options << ["The citation listed in the Non-Aligned Citations column does not address [type items here], as required by the standard.", "The citation listed in the Non-Aligned Citations column does not address [type item here], as required by the standard."]
    # notes_options << ["The citations listed in the Non-Aligned Citations column do not address [type items here], as required by the standard.", "The citations listed in the Non-Aligned Citations column do not address [type items here], as required by the standard."]
    # notes_options << ["Citation(s) that could not be Verified -------------------------------------------------------------------", ""]
    # notes_options << ["The citation listed in the Non-Aligned Citations column could not be verified because the link was not active.", "The citation listed in the Non-Aligned Citations column could not be verified because the link was not active."]
    # notes_options << ["The citations listed in the Non-Aligned Citations column could not be verified because the links were not active.", "The citations listed in the Non-Aligned Citations column could not be verified because the links were not active."]

    # puts notes_options.inspect

    # fv = FormValue.create!(:model_name => "Breakout", :attribute_name => "non-aligned-stems", :values_list => notes_options)

    # puts fv.inspect

    # puts "\n---------------------------------\n\n"
    # puts "Done."
    # puts "\n---------------------------------\n\n"

    # puts "Creating Pending Citation Stems Form Values..."

    # fv_orig = FormValue.all_of(:model_name => "Breakout", :attribute_name => "pending-citation-stems").first
    # if fv_orig
    #   fv_orig.delete
    # end


    # notes_options = []
    # notes_options << ["Select Appropriate Stem", ""]
    # notes_options << ["Citation(s) Lacking the Cognitive Demand -------------------------------------------------------------", ""]
    # notes_options << ["The citation listed in the Pending Citations column is not aligned to this standard because the material does not...", "The citation listed in the Pending Citations column is not aligned to this standard because the material does not require students to [...]"]
    # notes_options << ["The citations listed in the Pending Citations column are not aligned to this standard because the material does not...", "The citations listed in the Pending Citations column are not aligned to this standard because the material does not require students to [...]"]
    # notes_options << ["Citation(s) Lacking Content and/or Context -------------------------------------------------------------", ""]
    # notes_options << ["The citation listed in the Pending Citations column does not address [type items here], as required by the standard.", "The citation listed in the Pending Citations column does not address [type item here], as required by the standard."]
    # notes_options << ["The citations listed in the Pending Citations column do not address [type items here], as required by the standard.", "The citations listed in the Pending Citations column do not address [type items here], as required by the standard."]

    # puts notes_options.inspect

    # fv = FormValue.create!(:model_name => "Breakout", :attribute_name => "pending-citation-stems", :values_list => notes_options)

    # puts fv.inspect

    # puts "\n---------------------------------\n\n"
    # puts "Done."
    # puts "\n---------------------------------\n\n"
    # puts "Creating Although Not Listed Stems Form Values..."

    # fv_orig = FormValue.all_of(:model_name => "Breakout", :attribute_name => "although-not-listed-stems").first
    # if fv_orig
    #   fv_orig.delete
    # end


    # notes_options = []
    # notes_options << ["Select Appropriate Stem", ""]
    # notes_options << ["Although not listed in the publisher's correlation, [citation] also aligns to this standard.", "Although not listed in the publisher's correlation, [citation] also aligns to this standard."]
    # notes_options << ["Although not listed in the publisher's correlation, [citation] aligns to this standard.", "Although not listed in the publisher's correlation, [citation] aligns to this standard."]
    # notes_options << ["Although not listed in the publisher's correlation, [citations] also align to this standard.", "Although not listed in the publisher's correlation, [citations] also align to this standard."]
    # notes_options << ["Although not listed in the publisher's correlation, [citations] align to this standard.", "Although not listed in the publisher's correlation, [citations] align to this standard."]
    # notes_options << ["Addressed in publisher's correlation, but Learning List has not verified alignment to this standard.","Addressed in publisher's correlation, but Learning List has not verified alignment to this standard."]

    # puts notes_options.inspect

    # fv = FormValue.create!(:model_name => "Breakout", :attribute_name => "although-not-listed-stems", :values_list => notes_options)

    # puts fv.inspect

    # puts "\n---------------------------------\n\n"
    # puts "Done."
    puts "\n---------------------------------\n\n"
    puts "Creating Learing List Response Stems Form Values..."

    fv_orig = FormValue.all_of(:model_name => "Breakout", :attribute_name => "response-stems").first
    if fv_orig
      fv_orig.delete
    end


    notes_options = []
    notes_options << ["Select Appropriate Stem", ""]
    notes_options << ["The citation is not aligned to this standard because the material does not require students to [...]", "The citation is not aligned to this standard because the material does not require students to [...]"]
    notes_options << ["The citations are not aligned to this standard because the material does not require students to [...]", "The citations are not aligned to this standard because the material does not require students to [...]"]
    notes_options << ["The citation does not address [type item here], as required by the standard.", "The citation does not address [type item here], as required by the standard."]
    notes_options << ["The citations do not address [type items here], as required by the standard.", "The citations do not address [type items here], as required by the standard."]
    notes_options << ["Added [type item here], to the Aligned Citations column.","Added [type item here], to the Aligned Citations column."]
    notes_options << ["Moved [type item here] to the Aligned Citations column.","Moved [type item here] to the Aligned Citations column."]

    puts notes_options.inspect

    fv = FormValue.create!(:model_name => "Breakout", :attribute_name => "response-stems", :values_list => notes_options)

    puts fv.inspect
  end
end