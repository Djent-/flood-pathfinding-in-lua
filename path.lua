--path.lua
--2014.6.26
--pass a multidimensional table
--0 for passable, 1 for impassable

function path(t, startx, starty, endx, endy)
	if type(t) ~= "table" then error("Provide a table.") end
	if type(t[1]) ~= "table" then error("Provide a table of tables.") end

	local y, x = #t, #t[1]
	local _t = {}
	for _y = 1, y do
		_t[_y] = {}
		for _x = 1, x do
			if t[_y][_x] == 0 then
				_t[_y][_x] = x * y --passable
			else
				_t[_y][_x] = nil --impassable
			end
		end
	end
	flood(_t, startx, starty, 1)
	local path_points = {{endx, endy}}
	path_back(_t, endx, endy, path_points)
end

function flood(t, x, y, n)
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

function path_back(t, x, y, points)
	local temp_points = {}
	for a = -1, 1 do
		for b = -1, 1 do
			if not t[y + a] then break end
			if t[y + a][x + b] then
				if t[y + a][x + b] < t[y][x] then
					--it's a prospective path tile
					table.insert(temp_points, {x + b, y + a})
				end
			end
		end
	end
	if #temp_points == 0 then return end
	local path_tile = math.random(#temp_points)
	local xn, yn = temp_points[path_tile][1], temp_points[path_tile][2]
	table.insert(points, 1, {xn, yn})
	path_back(t, xn, yn, points)
end
