local remote = game.ReplicatedStorage.Remotes.SGun
local size   = Vector3.new(100000000046556165454654646565400, 100000000046556165454654646565400, 1000000000465561654546546465654)
local pos    = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local part   = game.Players.LocalPlayer.Character.HumanoidRootPart

game.Players.LocalPlayer.Chatted:Connect(function(msg)
    
    if msg:sub(1,7) == "/kabab" then


while wait() do
    
    print"rekted server"
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("This games security is bad.", "All")
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Crashded server", "All")
    remote:FireServer(pos, size,  BrickColor.new("Really red"), part)
end
        end
end)