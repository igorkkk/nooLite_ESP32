print('mqttpub now')
local count = 0
for _ in pairs(debug.getregistry()) do  count = count + 1 end
--wth.reg = '{"cell":65,"reg":"'..count..'"}' 
--wth.heap = '{"cell":65,"heap":"'..node.heap()..'"}'
local pubnow
pubnow = function(top, dt)
	top, dt = next(wth, top)
	if top and dat.broker then
		m:publish(dat.clnt..'/mtrf/'..top, dt, 2, 0, function() if pubnow then pubnow(top) end end)
	else
		--print(wth.heap, wth.reg)
		top, dt, pubnow, count = nil, nil, nil, nil
		wth = {} 
		if dat.boot then dofile('sendboot32.lua') end
		if comtb and #comtb > 0 then 
			dofile('run.lua') 
		else
			dat.running = false
			dat.killcmdtb:stop()
            dat.killcmdtb:unregister()
            dat.killcmdtb = nil
		end 
	end
end
pubnow()