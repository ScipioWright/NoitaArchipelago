local Global = dofile("data/archipelago/lib/globals_manager.lua")
local GlobalComplex = dofile("data/archipelago/lib/global_complex.lua")

return {
	LocationUnlockQueue = GlobalComplex("AP_COMPONENT_ITEM_UNLOCK_QUEUE"),
	Seed = Global("ARCHIPELAGO_SEED"),
	LoadKey = Global("ARCHIPELAGO_FIRST_LOAD_DONE"),

	ShopLocations = GlobalComplex("AP_SHOPLOCATION_DATA"),
	MissingLocationsSet = GlobalComplex("AP_MISSING_LOCATIONS"),
}