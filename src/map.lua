local sti = require 'libs.sti'

Map = {}
Map.__index = Map

function Map:load()

    self.map = sti('assets/map/mapv1.lua')

    setmetatable(self, Map)
    return self
end

function Map:update(dt)
    self.map:update(dt)
end

function Map:draw()
    self.map:draw()
end

return Map