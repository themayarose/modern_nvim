-- Reimplements https://github.com/kmiterror/dotnet-debug.nvim but with
-- configurable options

local M = {}

M.create_signer_script = function (signer_path)
    local content = string.format(
        [[
        const fs = require('fs');
        const signerLocation = '%s';

        try {
            const signerModule = require(signerLocation);
            const signer = new signerModule.signer();

            // Get payload from arguments
            const payload = process.argv[2];
            if (!payload) process.exit(1);

            // Sign and output
            process.stdout.write(signer.sign(payload));
        } catch (e) {
            console.error("Signer error:", e);
            process.exit(1);
        }
    ]],
        signer_path:gsub("\\", "\\\\")
    ) -- Escape for JS string

    local script_path = vim.fn.stdpath("cache") .. "/handshake_signer.js"
    local f = io.open(script_path, "w")
    if f then
        f:write(content)
        f:close()
        return script_path
    end
    return nil
end

M.extend_adapter = function (config)
    config = config or {}
    local rpc = require("dap.rpc")
    local signer_script = M.create_signer_script(vim.g.signer_path)

    local function RunHandshake(self, request_payload)
        local cmd = "node " .. signer_script .. " " .. request_payload.arguments.value
        local handle = io.popen(cmd)
        if not handle then
            return
        end

        local signature = handle:read("*a")
        handle:close()

        if signature then
            local response = {
                type = "response",
                seq = 0,
                command = "handshake",
                request_seq = request_payload.seq,
                success = true,
                body = { signature = signature },
            }
            self.client.write(rpc.msg_with_content_length(vim.json.encode(response)))
        end
    end

    return vim.tbl_deep_extend("force", config, {
        reverse_request_handlers = {
            handshake = RunHandshake,
        },
    })
end

return M
