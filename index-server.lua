-- PumaUpdater || Main Script
-- Author: gnmmarechal

-- May contain code from StarUpdater by astronautlevel

-- Version information
serverrel = 1
strver = "1.0.0"

if devmode == 1 then -- This will differentiate between stable and devscripts.
	version = version.."-D"
end

-- Handle auto-updates for the bootstrapper

function sleep(n)
  local timer = Timer.new()
  local t0 = Timer.getTime(timer)
  while Timer.getTime(timer) - t0 <= n do end
end

-- Colours
local colors =
{
	white = Color.new(255,255,255),
	yellow = Color.new(255,205,66),
	red = Color.new(255,0,0),
	green = Color.new(55,255,0)
}

-- Latest CIA URL
local latestCIA = "http://mirror.gs2012.xyz/3DS/HOMEBREW/CIA/UPDATERS/PumaUpdater/puma-bootstrapper.cia"

if relver > clientrel then
	while true do
		Screen.clear(TOP_SCREEN)
		Screen.debugPrint(5, 5, "Updating bootstrapper...", colors.yellow, TOP_SCREEN)
		Screen.debugPrint(5, 20, "Downloading new CIA...", colors.yellow, TOP_SCREEN)
		if System.doesFileExist("/PumaUpdater/Updater.cia") then
			System.deleteFile("/PumaUpdater/Updater.cia")
		end
		Network.downloadFile(latestCIA, "/PumaUpdater/Updater.cia")
		sleep(2000)
		Screen.debugPrint(5, 35, "Installing CIA...", colors.yellow, TOP_SCREEN)
		System.deleteFile("/PumaUpdater/Updater.CIA")
		System.exit()
	end		
end

-- Actual Updater script

-- URLs
url =
{
	stable = "http://mirror.gs2012.xyz/3DS/CFW/Puma33DS/updater/latest-stable.bin",
	stablever = "http://mirror.gs2012.xyz/3DS/CFW/Puma33DS/updater/stable-ver.txt",
	nightly = "http://mirror.gs2012.xyz/3DS/CFW/Puma33DS/updater/latest-nightly.bin",
	nightlyver = "http://mirror.gs2012.xyz/3DS/CFW/Puma33DS/updater/nightly-ver.txt"
}

vals =
{
	stablever = Network.requestString(url.stablever),
	nightlyver = Network.requestString(url.nightlyver)
}


-- Settings checks
if System.doesFileExist("/PumaUpdater/settings/usebgm") then
	usebgm = 1
end

if System.doesFileExist("/PumaUpdater/settings/keepconfig") then
	configkeep = 1
else
	configkeep = 0
end


-- Additional Paths

local payload_path = "/arm9loaderhax.bin"
local backup_path = payload_path..".bak"


local pad = Controls.read()
local oldpad = pad

-- Functions

function readConfig(fileName)
    if (System.doesFileExist(fileName)) then
        local file = io.open(fileName, FREAD)
        payload_path = io.read(file, 0, io.size(file))
        payload_path = string.gsub(payload_path, "\n", "")
        payload_path = string.gsub(payload_path, "\r", "")
        backup_path = payload_path..".bak"
    elseif (not System.doesFileExist(fileName)) then
		if System.doesFileExist("/arm9loaderhax_si.bin") and (not System.doesFileExist("/arm9loaderhax.bin")) then
			payload_path = "/arm9loaderhax_si.bin"
		else
			payload_path = "/arm9loaderhax.bin"
		end
        backup_path = payload_path..".bak"
        return
    end
end
