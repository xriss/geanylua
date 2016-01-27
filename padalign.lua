--[[

padalign

This will take some text on multiple lines and pad out the words so they align vertically. Like the text below.

useful for layout of repetitive data in code.

Lorem      Ipsum        is        simply      dummy      text       of         the         printing  and       typesetting
industry.  Lorem        Ipsum     has         been       the        industry's standard    dummy     text      ever       
since      the          1500s,    when        an         unknown    printer    took        a         galley    of         
type       and          scrambled it          to         make       a          type        specimen  book.     It         
has        survived     not       only        five       centuries, but        also        the       leap      into       
electronic typesetting, remaining essentially unchanged. It         was        popularised in        the       1960s      
with       the          release   of          Letraset   sheets     containing Lorem       Ipsum     passages, and        
more       recently     with      desktop     publishing software   like       Aldus       PageMaker including versions   
of         Lorem        Ipsum.   

--]]


-- simple hacky split
local split=function(str,pat)
	local t={}
	for line in string.gmatch(str, pat or "([^\n]+)") do
		t[#t+1]=line
	end
    return t
end

-- align a text block using whitespace
local f=function(s)
    local lines=split(s)
    
    local w={} -- build biggest widths
    for i,v in ipairs(lines) do
        local a=split(v,"([^%s]+)")
        for i,v in ipairs(a) do
            w[i]=w[i] or 0 -- make sure the width exists
            if w[i] < #v then w[i]=#v end -- store new width if its wider
        end
    end

    local t={} -- pad each word to the maximum width
    for i,v in ipairs(lines) do
        local a=split(v,"([^%s]+)")
        for i,v in ipairs(a) do
            if #v < w[i] then -- add padding
                a[i] = v..string.rep(" ",w[i]-#v)
            end
        end
        t[#t+1]=table.concat(a," ")
    end
    
	return table.concat(t,"\n").."\n"
end


-- apply to selected text only
local s=geany.selection()
if s then
	if s~="" then
		geany.selection(f(s))
	end
end




