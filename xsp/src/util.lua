_isDebug = true;

-- 点击方法


-- 格式化输出table（力荐）
function printTable (root, notPrint, params)

	if not _isDebug then
		do return end
	end
	local rootType = type(root)
	if rootType == "table" then
		local tag = params and params.tag or "Table detail:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
		local cache = {  [root] = "." }
		local isHead = false
		local function _dump(t, space, name)
			local temp = {}
			if not isHead then
				temp = {tag}
				isHead = true
			end
			for k,v in pairs(t) do
				local key = tostring(k)
				if cache[v] then
					table.insert(temp, "+" .. key .. " {" .. cache[v] .. "}")
				elseif type(v) == "table" then
					local new_key = name .. "." .. key
					cache[v] = new_key
					table.insert(temp, "+" .. key .. _dump(v, space .. (next(t, k) and "|" or " " ) .. string.rep(" ", #key), new_key))
				else
					table.insert(temp, "+" .. key .. " [" .. tostring(v) .. "]")
				end
			end
			return table.concat(temp, "\n" .. space)
		end
		if not notPrint then
			sysLog(_dump(root, "", ""))
			sysLog("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
		else
			return _dump(root, "", "")
		end
	else
		sysLog("[printr error]: not support type")
	end
end