--PumaUpdater - Puma33DS CFW Updater for the Nintendo 3DS || Bootstrapper Script (CORE)
--Author: gnmmarechal
--Runs on Lua Player Plus 3DS

-- This script fetches the latest updater script and runs it. If the server-side script has a higher rel number, the CIA will also be updated.
clientrel = 1
bootstrapver = "1.0.2"

if not Network.isWifiEnabled() then --Checks for Wi-Fi
	error("Failed to connect to the network.")
end

-- Set server script URL
stableserverscripturl = "http://gs2012.xyz/3ds/PumaUpdater/index-server.lua"
nightlyserverscripturl = "http://gs2012.xyz/3ds/PumaUpdater/index-nightly.lua"

-- Create directories
System.createDirectory("/PumaUpdater")
System.createDirectory("/PumaUpdater/settings")
System.createDirectory("/PumaUpdater/resources")


-- Check if user is in devmode or no (to either use index-server.lua or cure-nightly.lua)
if System.doesFileExist("/PumaUpdater/settings/devmode") then
	serverscripturl = nightlyserverscripturl
	devmode = 1
else
	serverscripturl = stableserverscripturl
	devmode = 0
end
-- Download server script
if System.doesFileExist("/PumaUpdater/cure.lua") then
	System.deleteFile("/PumaUpdater/cure.lua")
end
Network.downloadFile(serverscripturl, "/PumaUpdater/cure.lua")

-- Run server script
dofile("/PumaUpdater/cure.lua")
System.exit()
