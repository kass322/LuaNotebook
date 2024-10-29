require("iuplua")
--FONT
textfont = "Tahoma::11"

--IMAGES
img = iup.image -- the icon image
{
  width = 16,
  height = 16,
  pixels = {
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
   },
  colors = { 
    "0 0 200", -- index 0 
    "255 255 255", -- index 1
	"210 210 210" -- index 2
	}
}

--CONTROLS
text = iup.multiline{expand = "YES", font = textfont}

menu_s = iup.item{title = "Save"}
menu_l = iup.item{title = "Load"}
menu_a = iup.item{title = "About"}

mmenu = iup.menu{menu_s, menu_l, menu_a}

--FUNCTIONS
function menu_s:action() -- save button
	a = iup.Alarm("Confirm", "Are you sure you want to save the file?", "YES", "NO")
	if a == 1 then
		pth, err = iup.GetFile("txt")
		if err == 1 or err == 0 then
			local file = io.open(pth, "w")
			file:write(text.value)
			file:close()
		else
			iup.Message("Error", "You didn't selected a file!")
		end
	end
end

function menu_l:action() -- load file
	a = iup.Alarm("Confirm", "Are you sure you want to load the file?", "YES", "NO")
	if a == 1 then
		pth, err = iup.GetFile("txt")
		if err == 0 then
			local file = io.open(pth, "r")
			text.value = file:read("*all")
			file:close()
		else
			iup.Message("Error", "You didn't selected a file or file doesn't exist!")
		end
	end
end

function menu_a:action() -- about program
	iup.Message("about", "Lua Notebook\n\nMade in IupLuaScripter.")
end

--DIALOG WINDOW
dlg = iup.dialog{text;title = "Lua Notebook", size = "500x300", icon = img, menu = mmenu}
dlg:show()
iup.MainLoop()
