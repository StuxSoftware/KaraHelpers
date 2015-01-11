-- This function calculates the pct between the first loop line and the last loop line. Accellerations are allowed and they work like the \t-Accel.
-- Usually you only need tenv or in special cases "accel"
function calcTime(accel, pos, max_pos) if tenv._G.type(accel) == "nil" then accel = 1 end; if tenv._G.type(pos) == "nil" then pos = math.max(0, tenv.j) end; if tenv._G.type(max_pos) == "nil" then max_pos = math.max(1, tenv.maxj) end; return (pos / max_pos) ^ accel end;

-- This is one of the central functions of the library. It distributes all times of the lines created by a loop.
function distributeTimes() local start, stop = tenv.line.start_time, tenv.line.end_time; local duration = tenv.line.duration; local newstart = math.floor(start + (tenv.j - 1) / tenv.maxj * duration); local newend = math.floor(start + tenv.j / tenv.maxj * duration); tenv.retime("set", newstart, newend); return ""; end

-- Copied from NyuFX by Youka.
-- Returns the point on a beziere line with the
function beziere (pct, p) resultstr = "\\pos("; local function fac(n) local k = 1; if n > 1 then for i = 2,n do k = k * i; end; end; return k; end; local function bin(i, n) return fac(n) / (fac(i)*fac(n-i)) end; local function bernstein(pct, i, n) return bin(i, n) * pct^i * (1-pct)^(n-i); end; local point = {0,0}; local n = #p - 1; for i=0, n do local bern = bernstein(pct, i, n); point[1] = point[1] + p[i+1][1] * bern; point[2] = point[2] + p[i+1][2] * bern; end; resultstr = resultstr .. point[1] .. "," .. point[2]; return resultstr .. ")" end

-- Set the maximal loop execution proportional to the number of frames shown.
function frames(length) if tenv._G.type(length) == "nil" then length = (1000/(_G.frame_from_ms(1000) or 20)) end; local start, stop = tenv.line.start_time, tenv.line.end_time; tenv.retime("set", start + (tenv.j) * length, start + tenv.j*length); tenv.maxloop(math.max(math.floor((stop-start) / length), 1)); return ""; end;

-- Moves the list of vertices to the given position.
function move(pos, move) result = {}; for i=1,#move do result[i] = {}; result[i][1] = pos[1] + move[i][1]; result[i][2] = pos[2] + move[i][2]; end; return result; end

