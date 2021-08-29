_addon.author   = 'Original by JD4566'
_addon.version  = '1.0'
_addon.commands = {'test'}


require 'logger'
require 'strings'
require('coroutine')
packets = require('packets')
res = require('resources')



windower.ffxi.get_mob_by_id(17719638)	-- Try Targeting Rolandieene




function Rolandienne()			--Run to Rolandienne
	local me = windower.ffxi.get_mob_by_target('me')
	tp = windower.ffxi.get_mob_by_name('Rolandienne')
	if tp and math.sqrt(tp.distance) > 10 and not running then
		log('Running to Rolandienne')
		windower.ffxi.run(tp.x - me.x, tp.y - me.y)
		running = true
	elseif tp and math.sqrt(tp.distance) <= 10 then
		windower.ffxi.run(false)
		running = false
		local p = packets.new('outgoing', 0x01A, {
            ['Target'] = tp.id,
            ['Target Index'] = tp.index,
        })
        packets.inject(p)
		busy = true
		inside = true
	end
end


windower.register_event('outgoing chunk', function(id, data)          -- Positioning Check 

    if id == 0x015 then
        local data = packets.parse('outgoing', data)
        tPlayer["Position"]["X"] = data["X"]
        tPlayer["Position"]["Y"] = data["Y"]
        tPlayer["Position"]["Z"] = data["Z"]
        
        if data["Run Count"] > 2 then
            gMoving = true
        elseif data["Run Count"] == 2 then
            gMoving = false
        end

    end

end)




windower.register_event('addon command', function(...)
    local command = {...}
	if command[1] == 'stop' then
		pause = 'on'
		log('Stopping Rolandienne')
    elseif command[1] == 'start' then
		pause = 'off'
		log('Starting Rolandienne')
	end
end)


"H":2.33165073,"X":-126.676,"Y":-62.0,"Z":274.894},{"H":2.27903414,"X":-127.12281,"Y":-62.0,"Z":274.342255},{"H":2.264615,"X":-130.280563,"Y":-62.0,"Z":270.4979},{"H":2.28915739,"X":-132.439209,"Y":-61.9599648,"Z":268.0006}


