local ModuleLoader = {}

function ModuleLoader.Load(root: Instance)
    assert(typeof(root) == "Instance", "ModuleLoader.Load: root must be Instance")
    local modules = {}

    for _, moduleScript in ipairs(root:GetDescendants()) do
        if moduleScript:IsA("ModuleScript") then
            local ok, mod = pcall(require, moduleScript)
            if ok then
                modules[moduleScript.Name] = mod
            else
                warn(("ModuleLoader require failed for %s: %s"):format(
                    moduleScript:GetFullName(), tostring(mod)
                ))
            end
        end
    end

    -- Auto-Init any module with an Init() method
    for name, mod in pairs(modules) do
        if type(mod) == "table" and type(mod.Init) == "function" then
            task.spawn(function()
                local success, err = pcall(mod.Init, mod)
                if not success then
                    warn(("ModuleLoader Init error in %s: %s"):format(name, tostring(err)))
                end
            end)
        end
    end

    return modules
end

-- Call .Start() on each loaded module that defines it
function ModuleLoader.StartAll(modules: { [string]: any })
    for name, mod in pairs(modules) do
        if type(mod) == "table" and type(mod.Start) == "function" then
            task.spawn(function()
                local success, err = pcall(mod.Start, mod)
                if not success then
                    warn(("ModuleLoader Start error in %s: %s"):format(name, tostring(err)))
                end
            end)
        end
    end
end

return ModuleLoader
