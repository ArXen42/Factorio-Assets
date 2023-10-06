local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

for train_number, train in ipairs(game.surfaces[1].get_trains()) do
    if train.locomotives["front_movers"] == nil then
        game.print("Train " .. train_number .. " has no locomotive")
    else
        local locomotive = train.locomotives["front_movers"][1]
        local grid = locomotive.grid

        if train.schedule == nil then
            game.print("Train " .. train_number .. " has nil schedule")
        end

        if #train.fluid_wagons == 0 and #train.cargo_wagons == 0 then
            if not (train.schedule ~= nil and #train.schedule.records > 0 and train.schedule.records[1]["station"] == "[item=locomotive] Shuttle") then
                game.print("Train " .. train_number .. " has no cargo wagons")
                game.print(serpent.block(train.schedule.records))
            end
        end

        if tablelength(train.get_contents()) > 1 then
            game.print(serpent.block(train.get_contents()))
        end

        if grid == nil then
            error("grid not available")
        end

        if train.manual_mode then
            game.print("Train " .. train_number .. " was in manual mode")
            train.manual_mode = false
        end

        if grid.count() == 0 then
            grid.clear()
            for i = 1, 8, 1 do
                grid.put({ name = "advanced-additional-engine" })
            end
            grid.put({ name = "energy-absorber" })
            for i = 1, 3, 1 do
                grid.put({ name = "big-battery-mk3-equipment" })
            end

            game.print("Set train grid " .. train_number)
        end
    end
end
