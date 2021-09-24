--Not Sure entirely of the addon function just yet, but testing the waters....

_addon.author   = 'Boogies'
_addon.version  = '0.0.1'
_addon.commands = {'Boogies'}

require('logger')
require('coroutine')

--Declarations
pause = 'on'

local targetPos = {				--Build a table with desired coordinates
  {x=200.749, y= 23.493},
  {x=181.926, y= 6.921},
}
 
local myPos = {				--Build a table with my coordinates
  {x=203.396, y= 46.963},
  
}



function mover()
	windower.ffxi.run((targetPos.x - myPos.x), (targetPos.y - myPos.y))
	

end



function stopper()
	windower.ffxi.run(false)
	
	end



	
	windower.register_event('addon command', function(...)	--Setting starting and ending commands in game
    local command = {...}
    if command[1] == 'start' then
		mover()
        log('Starting Boogies! Enjoy (: ')
    elseif command[1] == 'stop' then
        pause = 'off'
		stopper()
        log('Stopping Boogies :( ')
    end
end)

return 0;


