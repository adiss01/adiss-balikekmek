Config = Config or {}


-- Kordinatlar
Config.Balikyeri = vector3(-1840.91, -1182.73, 14.328) -- balık pişirme
Config.ekmekyap = vector3(-1843.37, -1187.00, 14.327) -- balık ekmek hazırlama
Config.tbalikk = vector3(-1842.19, -1185.02, 14.327) -- balık temizleme
Config.sat = vector3(-1818.65, -1197.94, 14.469) -- balık satma alanı

--Balıkekmek satış fiyatı
Config.Fiyat = math.random(0, 35)


Config.zaman = 12500 -- Progbar zamanı
Config.zaman2 = 20000 -- Paketleme zamanı




----- İtemler
Config.balik =  'balik' -- normal balık itemi
Config.pbalik = 'balik1' -- pişmiş balık
Config.ybalik = 'balik2' -- yanmış balık
Config.marul = 'marul2' -- marul itemi
Config.bekmek = 'balikekmek' -- balık ekmek itemi
Config.ekmek = 'bread' -- ekmek itemi
Config.tbalik = 'balik3' -- temizlenmiş balık itemi


--- DRAWTEXTLER
Config.drwtxt = '[ ~g~ E ~w~ - Balık Pisir ]'
Config.bekmekdrwtxt = '[ ~g~ E ~w~ - Balık Ekmek Yap ]'
Config.satisdrwtxt = '[ ~g~ E ~w~ - Satısa Basla ]'
Config.bitir = '[ ~g~ H ~w~ - Satısı Bitir ]'
Config.balikt = '[ ~g~ E ~w~ - Balık Temizle ]'

--- minigame yada progbar kullanabilirsin yada npcye satışı kapatabilirsin
Config.minigame = true -- balık pişirme minigame
Config.NPCSat = true -- satış için true/false
Config.minigame2 = true -- skillbar


Config.bolge = {
    ["Satis Bolgesi-1"] = {
        ["kordinat"] = vector3(-1818.65, -1197.94, 14.469),
        ["esyalar"] = {
            "balikekmek"
        }
    }, 
}

-- Log için webhook
Config.webhook = 'https://discord.com/api/webhooks/779455744851443743/dDHEDR6e4oQwuWeDAw5PO3HjhFInJy-QQBjpQ-R-PWBF8Dw0CYr2nOOuTuR-_xEgghox'

