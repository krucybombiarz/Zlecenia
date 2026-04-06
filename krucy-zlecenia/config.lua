Config = {}

Config.ContractPed = {
    model = 'g_m_m_chigoon_01',
    coords = vec4(-1103.5, -1694.0, 4.4, 125.0) -- PED OD ZLECEN
}

Config.Reward = {
    min = 5000,
    max = 15000,
    account = 'black_money'
}

Config.Targets = { -- CELE ZLECEN
    {
        label = "Biznesmen w garniturze", -- NAZWA PEDA
        model = "a_m_m_business_01", -- MODEL PEDA
        weapon = "WEAPON_PISTOL" -- BRON KTORA MA PED
    },
    {
        label = "Gangster z Grove",
        model = "g_m_y_famfor_01",
        weapon = "WEAPON_MICROSMG"
    },
    {
        label = "Bezdomny",
        model = "a_m_m_tramp_01",
        weapon = "WEAPON_KNIFE"
    }
}

Config.Locations = { -- PRZYKLADOWE LOKALIZACJE SPAWNOW PEDOW
    vec3(-500.0, -200.0, 35.0),
    vec3(1200.0, -1300.0, 35.0),
    vec3(-1500.0, 500.0, 110.0),
    vec3(300.0, -800.0, 29.0)
}