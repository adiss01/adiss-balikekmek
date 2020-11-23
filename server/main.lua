--[[
                             _  _   _____ _____ _____ _____ 
              | (_)        _| || |_|  ___|  ___|  ___|  ___|
     __ _  __| |_ ___ ___|_  __  _|___ \|___ \|___ \|___ \ 
    / _` |/ _` | / __/ __|_| || |_    \ \   \ \   \ \   \ \
   | (_| | (_| | \__ \__ \_  __  _/\__/ /\__/ /\__/ /\__/ /
   \__,_|\__,_|_|___/___/ |_||_| \____/\____/\____/\____/     ^adişş 🔥#5555 
]]

ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj
end)

RegisterServerEvent('adiss:ekmekyap')
AddEventHandler('adiss:ekmekyap', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(Config.pbalik, 1)
    xPlayer.removeInventoryItem(Config.ekmek, 1)
    xPlayer.removeInventoryItem(Config.marul, 2)
    xPlayer.addInventoryItem(Config.bekmek, 1)
end)

RegisterServerEvent('adiss:additem')
AddEventHandler('adiss:additem', function(itemname, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(itemname, count)
end)

RegisterServerEvent('adiss:removeitem')
AddEventHandler('adiss:removeitem', function(itemname, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(itemname, count)
end)


RegisterServerEvent('adiss:para')
AddEventHandler('adiss:para', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(Config.bekmek, 1) 
    xPlayer.addMoney(Config.Fiyat, 1)
    dclog(xPlayer, '1 Adet Balık Ekmek Karşılıgında -  ' ..Config.Fiyat..' $ Aldı')
end)


ESX.RegisterServerCallback("adiss:itemkontrol", function(source, cb, itemname)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(itemname)["count"]

    if item >= 1 then
        cb(true)
    else
        cb(false) 
    end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
  
	if item.name == 'balikekmek' and item.count < 1 then
	  TriggerClientEvent('adiss:satısdur', source)
	end
end)

function dclog(xPlayer, text)
    local playerName = Sanitize(xPlayer.getName())
    
    local discord_webhook = GetConvar('discord_webhook', Config.webhook)
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = 'adiss - Balıkekmek-Log',
      ["avatar_url"] = 'https://cdn.discordapp.com/attachments/736920123079917579/740573179654963280/7a1ce7c3a09f95709a7a7ed6142ab39e_1.png',
      ["embeds"] = {{
        ["author"] = {
          ["name"] = playerName .. ' - ' .. xPlayer.identifier
        },
        ["color"] = 15158332,
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
      }}
    }
    data['embeds'][1]['description'] = text
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function Sanitize(str)
    local replacements = {
        ['&' ] = '&amp;',
        ['<' ] = '&lt;',
        ['>' ] = '&gt;',
        ['\n'] = '<br/>'
    }

    return str
        :gsub('[&<>\n]', replacements)
        :gsub(' +', function(s)
            return ' '..('&nbsp;'):rep(#s-1)
        end)
end
