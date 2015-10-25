util = {}

function util.replaceChar(str, newChar, pos)
	return table.concat{str:sub(1,pos-1), newChar, str:sub(pos+1)}
end
