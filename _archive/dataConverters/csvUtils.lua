-- Used to escape "'s by toCSV
function escapeCSV (s)

	if string.find(s, '[,"]') then
		s = '"' .. string.gsub(s, '"', '""') .. '"'
	end
	
	return s

end

-- Convert from CSV string to table (converts a single line of a CSV file)
function fromCSV (s)

	s = s .. ','        -- ending comma
	local t = {}        -- table to collect fields
	local fieldstart = 1
	local i  = fieldstart

	repeat
		-- next field is quoted? (start with `"'?)
		if string.find(s, '^"', fieldstart) then
			local a, c

			repeat
				-- find closing quote
				a, i, c = string.find(s, '"("?)', i+1)
			until c ~= '"'    -- quote not followed by quote?

			if not i then error('unmatched "') end

			local f = string.sub(s, fieldstart+1, i-1)
			table.insert(t, (string.gsub(f, '""', '"')))
			fieldstart = string.find(s, ',', i) + 1
		else                -- unquoted; find next comma
			local nexti = string.find(s, ',', fieldstart)
			table.insert(t, string.sub(s, fieldstart, nexti-1))
			fieldstart = nexti + 1
		end
	until fieldstart > string.len(s)

	for i = 1, fieldstart do
		t[i] = tonumber(t[i])
	end
	
	return t

end

-- Convert from table to CSV string
function toCSV (tt)

local s = ""

-- assumption is that fromCSV and toCSV maintain data as ordered array
for _,p in ipairs(tt) do  
	s = s .. "," .. escapeCSV(p)
end

return string.sub(s, 2)      -- remove first comma

end