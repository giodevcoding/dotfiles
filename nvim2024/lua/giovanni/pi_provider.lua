local Providers = require("99.providers")

local PiProvider = setmetatable({}, { __index = Providers.BaseProvider })

function PiProvider._build_command(_, query, context)
    -- pi's agent-modes extension auto-activates "build" mode on session_start,
    -- which overrides --model. build.md's frontmatter expands env vars, so the
    -- model is passed via env. --model is kept as a fallback if modes is off.
    local provider, model = context.model:match("^(.-)/(.+)$")
    provider = provider or "ollama-cloud"
    model = model or context.model
    return {
        "env",
        "PI_PROVIDER=" .. provider,
        "PI_MODE_BUILD_MODEL=" .. model,
        "pi",
        "--print",
        "--no-session",
        "--no-context-files",
        "--dangerously-skip-permissions",
        "--model",
        context.model,
        query,
    }
end

function PiProvider._get_provider_name()
    return "PiProvider"
end

function PiProvider._get_default_model()
    return "ollama-cloud/glm-5.3-flash"
end

function PiProvider.fetch_models(callback)
    vim.system({ "pi", "--list-models" }, { text = true }, function(obj)
        vim.schedule(function()
            if obj.code ~= 0 then
                callback(nil, "Failed to fetch models from pi")
                return
            end
            local models = {}
            for _, line in ipairs(vim.split(obj.stdout, "\n", { trimempty = true })) do
                local provider, model = line:match("^(%S+)%s+(%S+)")
                if provider and model and provider ~= "provider" then
                    table.insert(models, provider .. "/" .. model)
                end
            end
            callback(models, nil)
        end)
    end)
end

return PiProvider