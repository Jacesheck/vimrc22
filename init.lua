require("jace.packer")
require("jace.set")
require("jace.remap")
require("jace.functions")
require("mason").setup()

local function configure_debuggers()
    require("config.dap.python").setup()
    require("config.dap.csharp").setup()
end
