_addon.author   = 'JD4566 AKA BIG BOOG'
_addon.version  = '0.0.1'
_addon.commands = {'Salvage'}

require('logger')
require('coroutine')
packets = require('packets')
res = require('resources')
files = require 'files'
texts = require 'texts'
config = require 'config'



--Defaults
nexttime = os.clock()
delay = 0
busy = false
inside = false
running = false
fighting = false
waiting = false
tp = false
pause = 'on'
teleport_ring = "Warp ring"		--Set your teleport ring here



local conditions = {

	
	running = false,
	
	
}


function Zasshal()											-- Walks to Zasshal for Remants Permit

    log('Heading to Zasshal')
    

    local me = windower.ffxi.get_mob_by_target('me')
    local tp = windower.ffxi.get_mob_by_name('Zasshal')
    
    
    windower.ffxi.run(tp.x - me.x, tp.y - me.y, tp.z - me.z)
    conditions['running'] = true
    while conditions['running'] do
        if(math.sqrt(tp.distance)) <= 2 then
            conditions['running'] = false
        end
        tp = windower.ffxi.get_mob_by_name('Zasshal')
    end
    windower.ffxi.run(false)
    windower.send_command('setkey f8 down;wait 1;setkey f8 up')    
	coroutine.sleep(5)
	
    
    door()

end



function door()											-- Walks to Chamber of Passage and opens it

    log('Heading to chamber of passage!')
    

    local me = windower.ffxi.get_mob_by_target('me')
    local tp = windower.ffxi.get_mob_by_name('Door: Chamber of Passage')
    
    
    windower.ffxi.run(tp.x - me.x, tp.y - me.y, tp.z - me.z)
    conditions['running'] = true
    while conditions['running'] do
        if(math.sqrt(tp.distance)) <= 1 then
            conditions['running'] = false
        end
        tp = windower.ffxi.get_mob_by_name('Door: Chamber of Passage')
    end
    windower.ffxi.run(false)
    windower.send_command('setkey f8 down;wait 1;setkey f8 up;wait 1;setkey enter down;wait 1;setkey enter up;')    
	coroutine.sleep(3)
    
    sharin()							-- Go to next function

end



function sharin()											-- Walks Sharin-Garin

    log('Heading to Sharin-Garin!')
    

    local me = windower.ffxi.get_mob_by_target('me')
    local tp = windower.ffxi.get_mob_by_name('Sharin-Garin')
    
    
    windower.ffxi.run(tp.x - me.x, tp.y - me.y, tp.z - me.z)
    conditions['running'] = true
    while conditions['running'] do
        if(math.sqrt(tp.distance)) <= 1 then
            conditions['running'] = false
        end
        tp = windower.ffxi.get_mob_by_name('Sharin-Garin')
    end
    windower.ffxi.run(false)   
	windower.send_command('setkey numpad6 down;wait 0.75;setkey numpad6 up;')		--Added manual setkey to move out of way of wall
	coroutine.sleep(5)

    runic()
    

end

function runic()											-- Walks to Runic Portal and enters Nyzul Isle   *** Semi Bugged***

    log('Heading to Runic Portal!')
    

    local me = windower.ffxi.get_mob_by_target('me')
    local tp = windower.ffxi.get_mob_by_name('Runic Portal')
    
    
    windower.ffxi.run(tp.x - me.x, tp.y - me.y, tp.z - me.z)
    conditions['running'] = true
    while conditions['running'] do
        if(math.sqrt(tp.distance)) <= 0.5 then
            conditions['running'] = false
        end
        tp = windower.ffxi.get_mob_by_name('Runic Portal')
    end
    windower.ffxi.run(false)    
	coroutine.sleep(3)
	windower.send_command('setkey f8 down;wait 1;setkey f8 up;wait 3;setkey enter down;wait 0.5;setkey enter up;setkey down down;wait 3;setkey down up;setkey enter down;wait 1;setkey enter up;')--Nav Through Menu and selecting Nyzul Isle
	coroutine.sleep(5)

    
    

end



windower.register_event('addon command', function(...)
    local command = {...}
    if command[1] == 'start' then
		Zasshal()
		door()
		sharin()
		runic()
        log('Starting Salvage! Enjoy (: ')
    elseif command[1] == 'stop' then
        pause = 'off'
        log('Stopping Salvage :( ')
    end
end)

