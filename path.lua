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
		_t[_y] = {}
		for _x = 1, x do
			if t[y][x] == 0 then
				_t[_y][_x] = x * y --passable
			else
				_t[_y][_x] = 0 --impassable
			end
		end
	end
	flood(_t, startx, starty, 1)
end

local function flood(t, x, y, n)
	if not t[y] then return end
	if not t[y][x] then return end

	if t[y][x] > n then
		t[y][x] = n
	else
		return
	end
	flood(t, x + 1, y, n + 1) --right
	flood(t, x, y + 1, n + 1) --down
	flood(t, x + 1, y - 1, n + 1) --upper right
	flood(t, x, y - 1, n + 1) --up
	flood(t, x - 1, y, n + 1) --left
	flood(t, x - 1, y - 1, n + 1) --upper left
	flood(t, x - 1, y + 1, n + 1) --bottom left
	flood(t, x + 1, y + 1, n + 1) --bottom right
end
