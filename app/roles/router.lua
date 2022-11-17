local cartridge = require('cartridge')

local router_handlers = require('app.router.handlers')

local function init(opts) -- luacheck: no unused args
    -- if opts.is_master then
    -- end
    local httpd = assert(cartridge.service_get('httpd'), "Failed to get httpd service")
    -- CRUD
    httpd:route({method = 'GET', path = 'crud/:space'}, router_handlers.http_get)
    httpd:route({method = 'PUT', path = 'crud/:space'}, router_handlers.http_add)
    httpd:route({method = 'POST', path = 'crud/:space'}, router_handlers.http_replace)
    httpd:route({method = 'DELETE', path = 'crud/:space'}, router_handlers.http_delete)

    -- SQL
    return true
end

local function stop()
    return true
end

local function validate_config(conf_new, conf_old) -- luacheck: no unused args
    return true
end

local function apply_config(conf, opts) -- luacheck: no unused args
    -- if opts.is_master then
    -- end

    return true
end

return {
    role_name = 'app.roles.router',
    init = init,
    stop = stop,
    validate_config = validate_config,
    apply_config = apply_config,
    dependencies = {'cartridge.roles.crud-router'},
}
