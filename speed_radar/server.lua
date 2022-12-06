function sistem_calisma()
    for k,v in ipairs(map_objeler_tablo) do 
        obje=createObject(map_objeler_tablo[k][1],map_objeler_tablo[k][2],map_objeler_tablo[k][3],map_objeler_tablo[k][4],map_objeler_tablo[k][5],map_objeler_tablo[k][6],map_objeler_tablo[k][7])
        setElementInterior(obje,map_objeler_tablo[k][8])
        setElementDimension(obje,map_objeler_tablo[k][9])
        setObjectScale(obje,map_objeler_tablo[k][10])
    end
    for k,v in ipairs(radarlar) do
        radar_element = createMarker(radarlar[k][1],radarlar[k][2],radarlar[k][3],"cylinder",radarlar[k][4],255,0,0,0,getRootElement())
        addEventHandler("onMarkerHit",radar_element, markergiris)
        local ceza_tab = {
            {radarlar[k][5],radarlar[k][6]}
        }
        setElementData(radar_element,"radar_ceza_miktari",ceza_tab)
    end
end
function markergiris(hit)
    if getElementType(hit) == "vehicle" then 
        local ceza_tab = getElementData(source,"radar_ceza_miktari")
        if hiz(hit) > ceza_tab[1][1] then 
            takePlayerMoney(getVehicleOccupant(hit),ceza_tab[1][2])
            outputChatBox(ceza_tab[1][1].." Km/h Hız sınırını aştığınız için, "..ceza_tab[1][2].."$ para cezası kesilmiştir. #FFFFFFHIZINIZ =".."#FF0000"..math.floor(hiz(hit)).." Km/h",getVehicleOccupant(hit),255,0,0,true)
        end
    end
end

local speedMultiplier = 160
 
function hiz(arac)
local velX, velY, velZ = getElementVelocity( arac ) 
return math.sqrt( (velX * velX) + (velY * velY) + (velZ * velZ) ) * speedMultiplier
end

addEventHandler("onResourceStart",resourceRoot,sistem_calisma)

