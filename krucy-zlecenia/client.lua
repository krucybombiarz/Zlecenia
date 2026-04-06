local currentTarget = false
local targetPed = nil
local searchBlip = nil

CreateThread(function()
    local model = joaat(Config.ContractPed.model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    local ped = CreatePed(0, model, Config.ContractPed.coords.xyz, Config.ContractPed.coords.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'hitman_menu',
            icon = 'fa-solid fa-skull',
            label = 'Weź kontrakt',
            onSelect = function()
                OpenContractMenu()
            end
        }
    })
end)

function OpenContractMenu() -- MENU OX_LIB
    local options = {}

    for i, v in pairs(Config.Targets) do
        options[#options+1] = {
            title = v.label,
            onSelect = function()
                StartContract(v)
            end
        }
    end

    lib.registerContext({
        id = 'hitman_menu',
        title = 'Zlecenia zabójstw',
        options = options
    })

    lib.showContext('hitman_menu')
end

function StartContract(data) -- BRANIE ZLECEN
    if currentTarget then
        lib.notify({description = 'Masz już aktywny kontrakt!', type = 'error'})
        return
    end

    local baseLoc = Config.Locations[math.random(#Config.Locations)]

    local offsetX = math.random(-30, 30)
    local offsetY = math.random(-30, 30)

    local loc = vec3(
        baseLoc.x + offsetX,
        baseLoc.y + offsetY,
        baseLoc.z
    )

    searchBlip = AddBlipForCoord(loc.x, loc.y, loc.z)
    SetBlipSprite(searchBlip, 303)
    SetBlipColour(searchBlip, 1)
    SetBlipScale(searchBlip, 0.9)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Cel kontraktu")
    EndTextCommandSetBlipName(searchBlip)

    SetNewWaypoint(loc.x, loc.y)

    TriggerEvent('chat:addMessage', { -- WIADOMOSC NA CHAT (JESLI NIE CHCESZ DAJ -- PRZED)
        args = {"zlecenio dawca", "Cel: " .. data.label .. " | Lokalizacja oznaczona na GPS"}
    })

    SpawnTarget(data, loc)
    currentTarget = true
end

function SpawnTarget(data, coords)
    local model = joaat(data.model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    targetPed = CreatePed(0, model, coords.x, coords.y, coords.z, 0.0, true, true)
    GiveWeaponToPed(targetPed, joaat(data.weapon), 255, false, true)

    TaskWanderStandard(targetPed, true, true)

    CreateThread(function()
        while targetPed do
            Wait(1000)

            if IsEntityDead(targetPed) then
                TriggerServerEvent('hitman:reward')
                DeleteEntity(targetPed)

                if searchBlip then
                    RemoveBlip(searchBlip)
                end

                currentTarget = false
                targetPed = nil

                lib.notify({description = 'Kontrakt wykonany!', type = 'success'})
                break
            end
        end
    end)
end