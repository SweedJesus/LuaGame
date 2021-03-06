-- -----------------------------------------------
-- Class declaration
-- -----------------------------------------------
local BaseParticle = Class{
    __includes = BaseEntity
}
local this = BaseParticle

-- -----------------------------------------------
-- Function definitions
-- -----------------------------------------------
function this:init(x, y)
    BaseEntity.init(self, x, y)

    self.life_init = 1
    self.life = self.life_init

    self.dir = Vector(1, 0):rotated(math.random()*math.pi*2)
    self.vel = self.dir*math.random(60, 200)

    local i = math.random()
    if (i > 2/3) then
        self.mv_flags.r_l = true
    elseif (i > 1/3) then
        self.mv_flags.r_r = true
    end
end

function this:update(dt)
    BaseEntity.update(self, dt)

    -- Particle life
    self.life = self.life - 1 * dt
    if self.life <= 0 then
        BaseEntity.destroy(self)
    end
end

function this:draw()
    -- Draw mode
    if (self.__index == this.__index) then
        G.setColor(self.draw_col[1], self.draw_col[2], self.draw_col[3], 255*self.life/self.life_init)
    end
    BaseEntity.draw(self)

    -- Debug draw
    if (Debug.enabled) then
        if (Debug.draw_text) then
            -- Add lines to info print region
            self.info_pr:print({
                string.format("life=%s", self.life),
            })

            -- Draw print region if instance is of this class
            if (self.__index == this.__index) then
                self.info_pr:draw()
            end
        end
    end
end

return this

