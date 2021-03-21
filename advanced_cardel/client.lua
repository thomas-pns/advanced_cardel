--##################################--
-- Create by THOMAS#9033
-- Version: 1.0
--##################################--

-- DON'T TOUCH EXCEPT IF YOU KNOW WHAT YOU ARE DOING !
-- DON'T TOUCH EXCEPT IF YOU KNOW WHAT YOU ARE DOING !
-- DON'T TOUCH EXCEPT IF YOU KNOW WHAT YOU ARE DOING !

print("^2(RageUI V2) advanced_cardel is start, create by THOMAS#9033 !")

language = config.languages[config.lang]

if config.boolean_color then
    r=config.color.r
    g=config.color.g
    b=config.color.b
    a=config.color.a
else
    r=nil
    g=nil
    b=nil
    a=nil
end

if config.boolean_texture then
    texture=config.texture
else
    texture=nil
end

local ac = RageUI.CreateMenu(config.title, config.subtitle, nil, nil, "common", texture, r, g, b, a)

ac:DisplayGlare(config.glare_rui)
ac.TitleFont = config.TitleFont
ac.TitleScale = config.TitleScale

local index = {
	radius = 0,
	checkbox=false,
	checkbox2=false,
}

function notification(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
	if saveToBrief == nil then saveToBrief = true end
	AddTextEntry('notification', msg)
	BeginTextCommandThefeedPost('notification')
	if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
	EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
	EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		local next = true

		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function GetVehicles()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end

	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))

		if distance <= maxDistance then
			table.insert(nearbyEntities, isPlayerEntities and k or entity)
		end
	end

	return nearbyEntities
end


function GetVehiclesInArea(coords, radius) 
    return EnumerateEntitiesWithinDistance(GetVehicles(), false, coords, radius) 
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1.0)

        ped = PlayerPedId()
		ped_pos = GetEntityCoords(ped)

        if config.boolean_key then
            if IsControlJustReleased(config.key_type, config.key) then
                RageUI.Visible(ac, not RageUI.Visible(ac))
            end
        end

        RageUI.IsVisible(ac, function()
			RageUI.SliderProgress('Radius slider', index.radius, 100, nil, {
                ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 100 },
                ProgressColor = { R = 20, G = 150, B = 200, A = 255 },
            }, true, {
                onSliderChange = function(Index)
                    index.radius = Index
                end,
            })

			RageUI.Checkbox('Radius visible', nil, index.checkbox, {}, {
                onSelected = function(Index)
                    index.checkbox = Index
                end
            })

			RageUI.Checkbox('Markers visible', nil, index.checkbox2, {}, {
                onSelected = function(Index)
                    index.checkbox2 = Index
                end
            })

			local slider_float = index.radius*1.0
			local tabvehs = GetVehiclesInArea(ped_pos, slider_float)

			if index.checkbox then
				DrawSphere(ped_pos, slider_float, config.sphere_color.r, config.sphere_color.g, config.sphere_color.b, config.sphere_color.a)
			end

			if index.checkbox2 then
				for k,v in pairs(tabvehs) do
					--print(k,v)
					local posveh = GetEntityCoords(v)
					DrawMarker(config.marker.type --[[ integer ]], posveh.x, posveh.y, posveh.z+config.marker.z_add, 0.0 --[[ number ]], 0.0 --[[ number ]], 0.0 --[[ number ]], 180.0 --[[ number ]], 0.0 --[[ number ]], 0.0 --[[ number ]], config.marker.size --[[ number ]], config.marker.size --[[ number ]], config.marker.size --[[ number ]], config.marker.color.r --[[ integer ]], config.marker.color.g --[[ integer ]], config.marker.color.b --[[ integer ]], config.marker.color.a --[[ integer ]], false --[[ boolean ]], true --[[ boolean ]], 2 --[[ integer ]], config.marker.rotate --[[ boolean ]], nil --[[ string ]], nil --[[ string ]], false --[[ boolean ]])
				end
			end

			RageUI.Button(language['delcar']..'(radius : '..index.radius..')', nil, { RightLabel = "", Color = { HightLightColor = { 0, 155, 0, 150 }, BackgroundColor = { 0, 0, 0, 0 } }}, true, {
				onSelected = function() 
					local count = 0

					--print(ped_pos, slider_float)
					for k,v in pairs(tabvehs) do
						count=count+1
						DeleteEntity(v)
					end

                    notification(language['title_notif'], language['subject_notif'], '~r~'..count..' '..language['msg_notif'], config.notification_texture, config.notification_type, false, true, 160)
				end
			});
		end)
    end
end)

RegisterNetEvent("open:advanced_cardel")
AddEventHandler("open:advanced_cardel", function()
    RageUI.Visible(ac, not RageUI.Visible(ac))
end)