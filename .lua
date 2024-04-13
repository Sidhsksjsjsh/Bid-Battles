local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Plots")
local T3 = wndw:Tab("Upgrades")

local player = {
  self = game.Players.LocalPlayer,
  all = game.Players
}

local workspace = game:GetService("Workspace")

local var = {
  bid = false,
  sell = false,
  plots = {
    sf = false,
    ao = false
  },
  auct = false,
  map = {
    table = {},
    s = "1"
  },
  pass = false,
  sa = false,
  upg = {
    a = false,
    b = false,
    c = false
  }
}

local function setTable(m,f)
  table.insert(m,f)
end

for i = 1,62 do
  setTable(tostring(i),var.map.table)
end

local function children(path,f)
  for i,v in pairs(path:GetChildren()) do
    f(v)
  end
end

local function descendants(path,f)
  for i,v in pairs(path:GetDescendants()) do
    f(v)
  end
end

T1:Dropdown("Choose map number",var.map.table,function(value)
    var.map.s = value
end)

T1:Toggle("Instant join auction",false,function(value)
    var.auct = value
    while wait() do
      if var.auct == false then break end
      game:GetService("ReplicatedStorage")["Events"]["Auctions"]["EnterQueue"]:InvokeServer(var.map.s)
    end
end)

T1:Toggle("Auto bid",false,function(value)
    var.bid = false 
    while wait() do
      if var.bid == false then break end
        game:GetService("ReplicatedStorage")["Events"]["Auctions"]["PlaceBid"]:InvokeServer(125)
    end
end)

T1:Toggle("Auto pass",false,function(value)
    var.pass = value
    while wait() do
      if var.pass == false then break end
      game:GetService("ReplicatedStorage")["Events"]["Auctions"]["Pass"]:InvokeServer()
    end
end)

T1:Toggle("Instant sell furniture ( after auction )",false,function(value)
    var.sa = value
    while wait() do
      if var.sa == false then break end
      game:GetService("ReplicatedStorage")["Events"]["Auctions"]["SellAllItems"]:InvokeServer("Default",{})
    end
end)

T1:Button("End tutorial",function(value)
    game:GetService("ReplicatedStorage")["Events"]["Tutorial"]["EndTutorial"]:FireServer()
end)

T2:Toggle("Auto sell all ur furniture",false,function(value)
    var.plots.sf = value
    while wait() do
      if var.plots.sf == false then break end
      children(workspace.Plots,function(r)
          children(r,function(i)
              if i.Name == "Owner" and i.Value == player.self.Name then
                descendants(r["Furniture"],function(v)
                    game:GetService("ReplicatedStorage")["Events"]["Shop"]["SellItemInShop"]:FireServer("1",v,true)
                end)
              end
          end)
      end)
    end
end)

T2:Toggle("Auto accept offers",false,function(value)
    var.plots.ao = value
    while wait() do
      if var.plots.ao == false then break end
      children(workspace.Plots,function(r)
          children(r,function(i)
              if i.Name == "Owner" and i.Value == player.self.Name then
                descendants(r["Furniture"],function(v)
                    game:GetService("ReplicatedStorage")["Events"]["Shop"]["AcceptOfferServer"]:FireServer(v)
                end)
              end
          end)
      end)
    end
end)

T3:Toggle("Auto upgrade CarryLevel",false,function(value)
    var.upg.a = value
    while wait() do
      if var.upg.a == false then break end
        game:GetService("ReplicatedStorage")["Events"]["UI"]["UpgradeClicked"]:InvokeServer("CarryLevel")
      end
end)

T3:Toggle("Auto upgrade ShopLevel",false,function(value)
    var.upg.b = value
    while wait() do
      if var.upg.b == false then break end
        game:GetService("ReplicatedStorage")["Events"]["UI"]["UpgradeClicked"]:InvokeServer("ShopLevel")
      end
end)

T3:Toggle("Auto upgrade InventoryLevel",false,function(value)
    var.upg.c = value
    while wait() do
      if var.upg.c == false then break end
        game:GetService("ReplicatedStorage")["Events"]["UI"]["UpgradeClicked"]:InvokeServer("InventoryLevel")
      end
end)
