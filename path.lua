--path.lua
--2014.6.26
--pass a multidimensional table
--0 for passable, 1 for impassable

function path(t, startx, starty, endx, endy)
	if type(t) ~= "table" then error("Provide a table.")
	if type(t[1]) ~= "table" then error("Provide a table of tables.")

	local y, x = #t, #t[1]
	local _t = {}
	for _y = 1, y do
		for _x = 1, x do

		end
	end
end
