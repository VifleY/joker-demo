local function json_response(req, json, status) 
    local resp = req:render({json = json})
    resp.status = status
    return resp
end

local function internal_error_response(req, error)
    local resp = json_response(req, {
        info = "Internal error",
        error = error
    }, 500)
    return resp
end

local function not_found_response(req)
    local resp = json_response(req, {
        info = "Item not found"
    }, 404)
    return resp
end

local function conflict_response(req)
    local resp = json_response(req, {
        info = "Item already exist"
    }, 409)
    return resp
end

return {
    json_response = json_response,
    internal_error_response = internal_error_response,
    not_found_response = not_found_response,
    conflict_response = conflict_response,
}
