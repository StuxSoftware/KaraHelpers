function getSylY() if tenv["syl"] == nil then error("This function must be executed in a syllable template."); end; local syl = tenv.syl; if tenv.line.valign ~= "middle" then return syl.center; else local height = 0; local pos = 0; local lheight = 0; for si = 1,#tenv.line.kara do if not _G.is_syl_blank(tenv.line.kara[si]) then if tenv.line.kara[si].i <= syl.i then lheight = 0; end; for char in _G.unicode.chars(tenv.line.kara[si].text) do local w, h, d, e = _G.aegisub.text_extents(tenv.line.styleref, char); height = height + h; if tenv.line.kara[si].i <= syl.i then pos = pos + h; lheight = lheight + h; end; end end; end; return (meta.res_y-height)/2+pos-(lheight/2); end; end;

function getSylX() if tenv["syl"] == nil then error("This function must be executed in a syllable template."); end; local syl = tenv.syl; if tenv.line.valign ~= "middle" then return line.middle; else local m_r = meta.res_x-line.height/2; if tenv.line.halign == "right" then m_r = m_r - line.eff_margin_r; else if tenv.line.halign == "left" then m_r = m_r - line.eff_margin_l; end; end; return m_r; end; end;

function getSylText() if tenv["syl"] == nil then error("This function must be executed in a syllable template."); end; local syl = tenv.syl; if tenv.line.valign ~= "middle" then return syl.text; else local result = ""; local first = true; for char in _G.unicode.chars(tenv.syl.text) do if not first then result = result .. "\\N"; end; result = result .. char; first = false; end; return result; end; end;

--[[
  Basic Kanji Karaoke Placement
  template syl noblank notext
  {\an5\pos(!getSylX()!,!getSylY()!)}!getSylText()!
]]
