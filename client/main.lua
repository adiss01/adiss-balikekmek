--[[
                             _  _   _____ _____ _____ _____ 
              | (_)        _| || |_|  ___|  ___|  ___|  ___|
     __ _  __| |_ ___ ___|_  __  _|___ \|___ \|___ \|___ \ 
    / _` |/ _` | / __/ __|_| || |_    \ \   \ \   \ \   \ \
   | (_| | (_| | \__ \__ \_  __  _/\__/ /\__/ /\__/ /\__/ /
   \__,_|\__,_|_|___/___/ |_||_| \____/\____/\____/\____/     ^adişş 🔥#5555 
]]
         

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)  

local satilanNpcler = {}
local miktar, npc, bolgeKordinat, bolgeAdi = nil, nil, nil, nil, nil, nil, nil
local satisbasla, musteriBulundu, npcAra = false, false, false


RegisterNetEvent('adiss:basla')
AddEventHandler('adiss:basla', function()
    ESX.TriggerServerCallback("itemkontrol1", function(output)
        if output and Config.minigame == true then
            minigame()
            local ped = PlayerPedId()
            TaskStartScenarioInPlace(ped, "PROP_HUMAN_BBQ", 0, true)
        elseif output and Config.minigame == false then
            local ped = PlayerPedId()
            TaskStartScenarioInPlace(ped, "PROP_HUMAN_BBQ", 0, true)
            TriggerEvent('mythic_progbar:client:progress', {
                name = 'ahah',
                duration = Config.zaman,
                label = 'Balık Pişiriliyor...',
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                },
            }, function(status)
                if not status then
                    local ped = PlayerPedId()
                    TriggerServerEvent('adiss:removeitem2', Config.tbalik, 1)
                    TriggerServerEvent('adiss:additem2', Config.pbalik, 1)
                    ClearPedTasks(ped)
                end
            end)
        elseif not output then 
            exports['mythic_notify']:SendAlert('error', 'Üzerinde yeterince balık yok')
        end
    end, "balik3")
end)


RegisterNetEvent('adiss:paketle')
AddEventHandler('adiss:paketle', function()

    ESX.TriggerServerCallback("itemkontrol1", function(output)
        if output then
            TriggerEvent('mythic_progbar:client:progress', {
                name = 'ohoh',
                duration = Config.zaman2,
                label = 'Paketleniyor...',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "anim@amb@business@coc@coc_unpack_cut_left@",
                    anim = "coke_cut_v1_coccutter",
                },
            }, function(status)
                if not status then --anim@heists@ornate_bank@grab_cash_heels
                    TriggerServerEvent('adiss:ekmekyap')
                end
            end)
        elseif not output then 
            exports['mythic_notify']:SendAlert('error', 'gerekliler: 2x marul, 1x ekmek, 1x pişmiş balık')
        end
    end, "balik1", "marul2", "bread")
end)

RegisterNetEvent('adiss:balikt')
AddEventHandler('adiss:balikt', function()
    ESX.TriggerServerCallback("itemkontrol1", function(output)
        if output and Config.minigame2 == true then
            local playerPed = PlayerPedId()
            animasyon(playerPed, "anim@amb@business@coc@coc_unpack_cut_left@", "coke_cut_v1_coccutter")
            local finished = exports["reload-skillbar"]:taskBar(4000,math.random(5,15))
            if finished ~= 100 then
                ClearPedTasks(playerPed)
            else
                local finished2 = exports["reload-skillbar"]:taskBar(3000,math.random(5,15))
                if finished2 ~= 100 then
                    ClearPedTasks(playerPed)
                else
                    local finished3 = exports["reload-skillbar"]:taskBar(2500,math.random(5,15))
                    if finished3 ~= 100 then
                        ClearPedTasks(playerPed)
                    else
                        TriggerEvent('notification', 'Başarılı bir şekilde temizlendi')
                        TriggerServerEvent('adiss:removeitem2', Config.balik, 1)
                        TriggerServerEvent('adiss:additem2', Config.tbalik, 1)
                        ClearPedTasks(playerPed)
                    end
                end
            end
        elseif output and Config.minigame2 == false then
            TriggerEvent('mythic_progbar:client:progress', {
                name = 'ohoh',
                duration = Config.zaman2,
                label = 'Temizleniyor...',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "anim@amb@business@coc@coc_unpack_cut_left@",
                    anim = "coke_cut_v1_coccutter",
                },
            }, function(status)
                if not status then
                    TriggerServerEvent('adiss:removeitem2', Config.balik, 1)
                    TriggerServerEvent('adiss:additem2', Config.tbalik, 1)
                end
            end)
        elseif not output then 
            exports['mythic_notify']:SendAlert('error', 'Yeterli balığın yok')
        end
    end, "balik")
end)



Citizen.CreateThread(function()
    while true do 
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist = GetDistanceBetweenCoords(pos, Config.Balikyeri.x, Config.Balikyeri.y, Config.Balikyeri.z, true)
        local dist2 = GetDistanceBetweenCoords(pos, Config.ekmekyap.x, Config.ekmekyap.y, Config.ekmekyap.z, true)
        local dist3 = GetDistanceBetweenCoords(pos, Config.tbalikk.x, Config.tbalikk.y, Config.tbalikk.z, true)

        local sleep = 2000
        if dist < 1 then
            sleep = 7
            DrawText3Ds(Config.Balikyeri.x, Config.Balikyeri.y, Config.Balikyeri.z , Config.drwtxt)
            if IsControlJustReleased(0, 38) then
               TriggerEvent('adiss:basla')
            end
        end

        if dist2 < 1 then
            sleep = 7
            DrawText3Ds(Config.ekmekyap.x, Config.ekmekyap.y, Config.ekmekyap.z , Config.bekmekdrwtxt)
            if IsControlJustReleased(0, 38) then
               TriggerEvent('adiss:paketle')
            end
        end

        if dist3 < 1 then
            sleep = 7
            DrawText3Ds(Config.tbalikk.x, Config.tbalikk.y, Config.tbalikk.z , Config.balikt)
            if IsControlJustReleased(0, 38) then
               TriggerEvent('adiss:balikt')
            end
        end
    Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do 
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist = GetDistanceBetweenCoords(pos, Config.sat.x, Config.sat.y, Config.sat.z, true)
        local sleep = 2000
        if Config.NPCSat == true then
            if dist < 1 and not satisbasla then
                sleep = 7
                DrawText3Ds(Config.sat.x, Config.sat.y, Config.sat.z , Config.satisdrwtxt)
                ESX.TriggerServerCallback("itemkontrol1", function(output)
                    if IsControlJustReleased(0, 38) then
                       --TriggerEvent('adiss:sat')
                       exports['mythic_notify']:SendAlert('inform', 'işe başladın.')
                       satisbasla = true
                       musteriBulundu = false
                       npcAra = true           
                    end
                end, "balikekmek")
            elseif dist < 1 and satisbasla then
                sleep = 7
                DrawText3Ds(Config.sat.x, Config.sat.y, Config.sat.z , Config.bitir)
                if IsControlJustReleased(0, 74) then
                    satisbasla = false
                    musteriBulundu = false
                    npcAra = false
                    exports['mythic_notify']:SendAlert('inform', 'işi bitirdin.')
                end
            elseif satisbasla and dist > 100 then
                sleep = 7
                satisbasla = false
                musteriBulundu = false
                npcAra = false
                exports['mythic_notify']:SendAlert('error', 'Bölgeden uzaklaştığın için işten çıktın')
            end
        end
    Wait(sleep)
    end
end)

RegisterNetEvent('adiss:sat')
AddEventHandler('adiss:sat', function()
    local playerPed = PlayerPedId()

    ESX.TriggerServerCallback("itemkontrol1", function(output)
        if not IsPedInAnyVehicle(playerPed) and output then			
            satisbasla = true
            musteriBulundu = false
            npcAra = true
	    elseif IsPedInAnyVehicle(playerPed) then
            exports['mythic_notify']:SendAlert('inform', 'Araçta Satış Yapamassın')
            satisbasla = false
            musteriBulundu = false
            npcAra = false
        elseif not output then
            exports['mythic_notify']:SendAlert('inform', 'Üzerinde Yeterli Balık Ekmek Yok')
            satisbasla = false
            musteriBulundu = false
            npcAra = false
        end
    end, "balikekmek")
end)

Citizen.CreateThread(function()
    local wait = 2000
	while true do
		wait = 100
		if satisbasla then
			if not musteriBulundu and npcAra then
				wait = 5000
				local playerPed = PlayerPedId()
				local playerCoords = GetEntityCoords(playerPed)

				local bolgeBulundu = false
				for kodadi, bolge in pairs(Config.bolge) do
					local bolgeKordinat = bolge["kordinat"]
					if #(bolgeKordinat - playerCoords) < 45 then
						bolgeAdi = kodadi
						bolgeBulundu = true
						break
					end
				end

				if bolgeBulundu then
					exports['mythic_notify']:SendAlert('inform', 'Satış devam ediyor')
					Citizen.Wait(3000)
					npc = pedAra(playerPed)
				else
					satisbasla = false
					npcAra = false
					musteriBulundu = false
					exports['mythic_notify']:SendAlert('inform', 'Burada satış yapamazsın')
				end
			end

			if musteriBulundu and not npcAra and not satilanNpcler[npc] then
				wait = 1
				local playerPed = PlayerPedId()
				local playerCoords = GetEntityCoords(playerPed)
				local npcCoords = GetEntityCoords(npc)
				local npcMesafe = #(npcCoords - playerCoords)

				if #(bolgeKordinat - playerCoords) < 100 then
					if npcMesafe < 50 then
						local npcArabada = IsPedInAnyVehicle(npc)
						if npcArabada then
							npcAraci = GetVehiclePedIsIn(npc, false)
						end

						DrawText3Ds(npcCoords.x, npcCoords.y, npcCoords.z+1.05, "~g~[E] ~w~ 1 Adet balık ekmek sat / ~r~ [H] ~w~ Kov", 0.45)
						
						if HasEntityBeenDamagedByAnyPed(npc) then
							exports['mythic_notify']:SendAlert('inform', 'Alıcıyı dövdün')
                            npcAramayaDevam(true)							
						elseif npcMesafe <= 2.0 or npcArabada and npcMesafe < 15 then
							if npcArabada then
								FreezeEntityPosition(npcAraci, true)
							else
								FreezeEntityPosition(npc, true)
								animasyon(npc, "anim@amb@clubhouse@mini@darts@", "wait_idle")
							end

							if npcMesafe <= 2.0 then
								if IsControlJustPressed(0, 51) then -- E
									satilanNpcler[npc] = true
                                            TriggerServerEvent('adiss:para2', source)
											animasyon(playerPed, "mp_common", "givetake1_a")
											Citizen.Wait(350)
											if not npcArabada then animasyon(npc, "mp_common", "givetake1_a") end
                                            npcAramayaDevam(false)
                                            Citizen.Wait(7500)
											npcAramayaDevam(true)
									Citizen.Wait(5000)
								elseif IsControlJustPressed(0, 304) then -- H
									exports['mythic_notify']:SendAlert('inform','Alıcıyı kovdun')
									npcAramayaDevam(true)																
								end
							end
						else
							if npcArabada then
								FreezeEntityPosition(npcAraci, false)
							else
								FreezeEntityPosition(npc, false)
							end
						end
					else
						exports['mythic_notify']:SendAlert('inform', 'Alıcı senden uzaklaştı')
						npcAramayaDevam(true)	
					end
				else
					exports['mythic_notify']:SendAlert('inform', 'Alıcıya çok uzaksın')
					musteriBulundu = false
					npcAra = false
					satisbasla = false
				end
			end
		end
	Citizen.Wait(wait)
	end
end)

function animasyon(ped, ad, anim)
	ESX.Streaming.RequestAnimDict(ad, function()
		TaskPlayAnim(ped, ad, anim, 8.0, -8.0, -1, 0, 0, 0, 0, 0)
	end)
end


function pedAra(playerPed)
	local playerCoords = GetEntityCoords(playerPed)
	local handle, ped = FindFirstPed()
	local success
	local rped = nil
	repeat
		local mesafe = #(playerCoords - GetEntityCoords(ped))
		if mesafe < 30.0 and not IsPedAPlayer(ped) and not satilanNpcler[ped] then
			rped = ped
			if not IsPedInAnyVehicle(rped) then
				exports['mythic_notify']:SendAlert('inform', 'Alıcı sana doğru yaklaşıyor')
			else
				exports['mythic_notify']:SendAlert('inform', 'Alıcı senden bişe almak istemiyor')
			end

		
			bolgeKordinat = playerCoords
			satilanNpcler[rped] = false
			musteriBulundu = true
			npcAra = false
			break
		end
		success, ped = FindNextPed(handle)
	until not success
	EndFindPed(handle)
	return rped
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		if musteriBulundu and not IsPedInAnyVehicle(npc) then
			local playerPed = PlayerPedId()
	        local playerPos = GetEntityCoords(playerPed)
			TaskGoToCoordAnyMeans(npc, playerPos, 1.0, 0, 0, 786603, 0xbf800000)
		end	
	end
end)

function npcAramayaDevam(listeEkle)
	if listeEkle then
		satilanNpcler[npc] = true
    end
    
    Citizen.Wait(2000)
    
	if IsPedInAnyVehicle(npc) then
		local arac = GetVehiclePedIsIn(npc, false)
		TaskWanderStandard(arac, 10.0, 10)
		FreezeEntityPosition(arac, false)
	else
		TaskWanderStandard(npc, 10.0, 10)
		FreezeEntityPosition(npc, false)
		ClearPedTasks(npc)
    end
    
	ClearPedTasks(playerPed)
	Citizen.Wait(5000)
	musteriBulundu = false
	npcAra = true
end


function minigame()
    TriggerEvent('qb-keyminigame:show')
    TriggerEvent('qb-keyminigame:start', FinishMinigame)
end

function anim()
    local ped = PlayerPedId()
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_BBQ", 0, true)
end


function FinishMinigame(faults)
    local ped = PlayerPedId()
    
    if faults <= 2  then
        exports['mythic_notify']:SendAlert('inform', 'Sen 1 Adet Balık Eti Pişirdin!')
        TriggerServerEvent('adiss:normalbalik')
        TriggerServerEvent('adiss:removeitem2', Config.tbalik, 1)
        TriggerServerEvent('adiss:additem2', Config.pbalik, 1)
        ClearPedTasks(ped)
    elseif faults >= 3 then
        exports['mythic_notify']:SendAlert('inform', 'Sen 1 Adet Yanmış Balık Eti Pişirdin!')
        TriggerServerEvent('adiss:removeitem2', Config.tbalik, 1)
        TriggerServerEvent('adiss:additem2', Config.ybalik, 1)
        ClearPedTasks(ped)
    else
        exports['mythic_notify']:SendAlert('inform', 'Balığın Kalmadı')
        ClearPedTasks(ped)
    end
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterCommand('balikfix', function()
    satisbasla = false
    musteriBulundu = false
    npcAra = false   
    exports['mythic_notify']:SendAlert('error', 'Üzerinizde balık ekmek kalmadığı için iş durduruldu.')
end)
