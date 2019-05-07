local policetable = {}
local ambulancetable = {}
ESX                 = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(identifier, callback)
 
	MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier", {['@identifier'] = identifier},
	function(result)
	  if result[1]['firstname'] ~= nil then
		local data = {
		  identifier    = result[1]['identifier'],
		  firstname     = result[1]['firstname'],
		  lastname      = result[1]['lastname'],
		  dateofbirth   = result[1]['dateofbirth'],
		  sex           = result[1]['sex'],
		  height        = result[1]['height'],
		  phone_number  = result[1]['phone_number']
		}
		callback(data)
	  else
		local data = {
		  identifier    = '',
		  firstname     = '',
		  lastname      = '',
		  dateofbirth   = '',
		  sex           = '',
		  height        = '',
		  phone_number  = '',
		}
		callback(data)
	  end
	end)
  end


---//Ambulance//---
-------------------------------------------------------------------
RegisterServerEvent('esx_tracker:addAmbulanceToTable')
AddEventHandler('esx_tracker:addAmbulanceToTable',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()
	local i = GetPlayerName(source) 
	
	if  #ambulancetable > 0 then
	
		for k,v in pairs(ambulancetable) do
			if ambulancetable[k].i == i then
				table.remove(ambulancetable,k)
				
			end
		end
	end
	
	getIdentity(identifier, function(data)
	
		table.insert(ambulancetable, {
			i = i,
			name = (data.firstname..' '..data.lastname)
		})

		showblips = true
		TriggerClientEvent('esx_tracker:updateAmbulance',-1,ambulancetable,i,showblips)
	end)
end)


RegisterServerEvent('esx_tracker:removeAmbulanceFromTable')
AddEventHandler('esx_tracker:removeAmbulanceFromTable',function()

	local i = GetPlayerName(source)	

	for k,v in pairs(ambulancetable) do
		if ambulancetable[k].i == i then
			table.remove(ambulancetable,k)
		end
	end
		showblips = false
		TriggerClientEvent('esx_tracker:updateAmbulance',-1,ambulancetable,i,showblips)
end)



--------------------------------------------------------------------------------- 
  
  


---//Police//---
RegisterServerEvent('esx_tracker:addPoliceToTable')
AddEventHandler('esx_tracker:addPoliceToTable',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()
	local i = GetPlayerName(source) 
	
	if  #policetable > 0 then
	
		for k,v in pairs(policetable) do
			if policetable[k].i == i then
				table.remove(policetable,k)
				
			end
		end
	end
	
	getIdentity(identifier, function(data)
	
		table.insert(policetable, {
			i = i,
			name = (data.firstname..' '..data.lastname)
		})

		showblips = true
		TriggerClientEvent('esx_tracker:updatePolice',-1,policetable,i,showblips)
	end)
end)


RegisterServerEvent('esx_tracker:removePoliceFromTable')
AddEventHandler('esx_tracker:removePoliceFromTable',function()

	local i = GetPlayerName(source)	

	for k,v in pairs(policetable) do
		if policetable[k].i == i then
			table.remove(policetable,k)
		end
	end
		showblips = false
		TriggerClientEvent('esx_tracker:updatePolice',-1,policetable,i,showblips)
end)
-----------------------------------------------------------------------------------

TriggerEvent('es:addCommand', 'trackOFF', function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)
	
	
	--//Police//--
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
	
		local i = GetPlayerName(source)	
		
		for k,v in pairs(policetable) do
			if policetable[k].i == i then
				table.remove(policetable,k)
			end
		end
		
			showblips = false
			TriggerClientEvent('esx_tracker:updatePolice',-1,policetable,i,showblips)
	end
	
	--//Ambulance//--
	
	if xPlayer.job.name == 'ambulance' then
	
		local i = GetPlayerName(source)	
		
		for k,v in pairs(ambulancetable) do
			if ambulancetable[k].i == i then
				table.remove(ambulancetable,k)
			end
		end
		
			showblips = false
			TriggerClientEvent('esx_tracker:updateAmbulance',-1,ambulancetable,i,showblips)
	end
end)

TriggerEvent('es:addCommand', 'trackON', function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()
	
	--//Police//--
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
		local i = GetPlayerName(source)	
		
		if  #policetable > 0 then
			for k,v in pairs(policetable) do
				if policetable[k].i == i then
					table.remove(policetable,k)
				end
			end
		end
	
		getIdentity(identifier, function(data)
	
			table.insert(policetable, {
				i = i,
				name = (data.firstname..' '..data.lastname)
			})

				showblips = true
				TriggerClientEvent('esx_tracker:updatePolice',-1,policetable,i,showblips)
		end)
	end
	
	--//Ambulance//--
	if xPlayer.job.name == 'ambulance' then
		local i = GetPlayerName(source)	
		
		if  #ambulancetable > 0 then
			for k,v in pairs(ambulancetable) do
				if ambulancetable[k].i == i then
					table.remove(ambulancetable,k)
				end
			end
		end
	
		getIdentity(identifier, function(data)
	
			table.insert(ambulancetable, {
				i = i,
				name = (data.firstname..' '..data.lastname)
			})

				showblips = true
				TriggerClientEvent('esx_tracker:updateAmbulance',-1,ambulancetable,i,showblips)
		end)
	end
end)





