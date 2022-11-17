
local cartridge = require('cartridge')
local crud = require('crud')
local errors = require('errors')
local log = require('log')

local http_utils = require('app.utils.http')

local err_httpd = errors.new_class("httpd error")

local DEFAULT_OPTS = {
    timeout = 10,
}

local function http_add(req)
    local space_name = req:stash('space')
    local obj = req:json()

    local res, err = crud.insert_object(space_name, obj, DEFAULT_OPTS)
    if err then
        return http_utils.internal_error_response(req, err)
    end

    return http_utils.json_response(req, res, 201)
end

local function http_replace(req)
    local space_name = req:stash('space')
    local obj = req:json()

    local res, err = crud.replace_object(space_name, obj, DEFAULT_OPTS)
    if err then
        return http_utils.internal_error_response(req, err)
    end

    return http_utils.json_response(req, res, 200)
end

local function http_get(req)
    local space_name = req:stash('space')
    local key = tonumber(req:query_param('key'))

    local opts = DEFAULT_OPTS
    local res, err = crud.get(space_name, key, opts)
    if err then
        return http_utils.internal_error_response(req, err)
    end

    return http_utils.json_response(req, res, 200)
end

local function http_delete(req)
    local space_name = req:stash('space')
    local key = tonumber(req:query_param('key'))

    local res, err = crud.delete(space_name, key, DEFAULT_OPTS)
    if err then
        return http_utils.internal_error_response(req, err)
    end

    return http_utils.json_response(req, res, 200)
end

return {
    http_add = http_add,
    http_get = http_get,
    http_replace = http_replace,
    http_delete = http_delete,
}