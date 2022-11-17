# Simple Tarantool CRUD application

That is a demo of Tarantool application. It uses [`Tarantool Cartridge`](https://github.com/tarantool/cartridge.git) and [`crud`](https://github.com/tarantool/crud.git) module to provide CRUD API over distributed cluster and exposes a part of its API via HTTP interface - see [`OpenAPI`](./docs/openapi.yml).

## Quick start

To build application and setup topology:

```bash
cartridge build
cartridge start -d
cartridge replicasets setup --bootstrap-vshard
```

Now you can visit http://localhost:8081 and see your application's Admin Web UI.
CRUD API could be accessed on instances with `app.custom.router` role enabled.

**Note**, that application stateboard is always started by default.
See [`.cartridge.yml`](./.cartridge.yml) file to change this behavior.

To configure database scheme - refer to [`Cartridge documentation`](https://www.tarantool.io/en/doc/latest/book/cartridge/cartridge_admin/#updating-the-configuration) and [`DDL docs`](https://github.com/tarantool/ddl).
For the purposes of the demo you can just proceed to `Code` tab in Web UI and uncomment example schema.
## Application

Application entry point is [`init.lua`](./init.lua) file.
It configures Cartridge, initializes admin functions and exposes metrics endpoints.
Before requiring `cartridge` module `package_compat.cfg()` is called.
It configures package search path to correctly start application on production
(e.g. using `systemd`).

## Roles

Application has 2 simple role, [`app.roles.router`](./app/roles/router.lua) and [`app.roles.storage`](.app/roles/storage.lua).

Those implements simplified CRUD API over HTTP.
Router has a builtin HTTP server exposing a few endpoints - see [`OpenAPI`](./docs/openapi.yml). That roles "routes" requests to storages to retrive data according to sharding keys that is so external client does not care about cluster topology and sharding mechanics at all.

Storage is role for instances that actually stores data.

Also, Cartridge roles [are registered](./init.lua)
(`vshard-storage`, `vshard-router` and `metrics`).

You can add your own role, but don't forget to register in using
`cartridge.cfg` call.

## Instances configuration

Configuration of instances that can be used to start application
locally is places in [instances.yml](./instances.yml).
It is used by `cartridge start`.

## Topology configuration

Topology configuration is described in [`replicasets.yml`](./replicasets.yml).
It is used by `cartridge replicasets setup`.
