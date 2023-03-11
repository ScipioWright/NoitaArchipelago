local Biomes = dofile("data/archipelago/scripts/ap_biome_mapping.lua")
local Globals = dofile("data/archipelago/scripts/globals.lua")

local function APHeartReplacer()
    -- sets a function for the old version of spawn_heart
    local ap_old_spawn_heart = spawn_heart

    local function ap_replace_heart(x, y)
        local biome_name = BiomeMapGetName(x, y)
        -- check if the biome has checks left, if not then just spawn a chest/heart as normal
        for _, biome_data in pairs(Biomes) do
            if biome_name == biome_data.name then
                for i = biome_data.first_hc, biome_data.first_hc + 19 do
                    if Globals.MissingLocationsSet:has_key(i) then
                        -- spawn the chest, set ap_chest_id equal to its entity ID
                        local ap_chest_id = EntityLoad("data/archipelago/entities/items/pickup/ap_chest_random.xml", x, y)
                        EntityAddComponent(ap_chest_id, "VariableStorageComponent",
                                {
                                    name = "biome_name",
                                    value_string = biome_name,
                                })

                        -- if the chest manages to spawn outside of a biome, just kill it and spawn a normal heart or chest instead
                        if biome_name == "_EMPTY_" then
                            EntityKill(ap_chest_id)
                            ap_old_spawn_heart(x, y)
                        end
                        break

                        -- do nothing, continue with the script
                    else
                        ap_old_spawn_heart(x, y)
                        break
                    end
                end
            end
        end
    end


    -- this makes the spawn_heart the game calls for redirect to ap_replace_heart
    spawn_heart = function(x, y)
        ap_replace_heart(x, y)
    end
end

APHeartReplacer()
