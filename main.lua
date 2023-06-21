local bounds = {
    x=5000,y=5000,z=5000
}

local colors = {
    background={0x21,0x05,0x35},
    foreground={0xf5,0xd5,0xe0}
}

function love.load()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(colors.background))

    w,h=love.graphics.getDimensions()

    stars={}
    for i=1,0.75*w do
        stars[i]={
            x=love.math.random(-bounds.x,bounds.x),
            y=love.math.random(-bounds.y,bounds.y),
            z=love.math.random(0,bounds.z)
        }
        stars[i].pz=stars[i].z
    end
end

function love.update(dt)
    for _,star in ipairs(stars) do
        star.z=star.z - love.mouse.getX()*5 * dt
        if star.z < 0 then
            star.x=love.math.random(-bounds.x,bounds.x)
            star.y=love.math.random(-bounds.y,bounds.y)
            star.z=bounds.z
            star.pz=star.z
        end
    end
end

function love.draw()
    love.graphics.translate(w/2,h/2)

    for _,star in ipairs(stars) do
        local x,y,z=w/3*star.x/star.z,h/3*star.y/star.z,3/bounds.z*(bounds.z-star.z)
        local px,py=w/3*star.x/star.pz,h/3*star.y/star.pz
        star.pz=star.z

        love.graphics.setLineWidth(z)
        colors.foreground[4]=500/bounds.z*(bounds.z-star.z)
        love.graphics.setColor(love.math.colorFromBytes(colors.foreground))
        love.graphics.line(x,y,px,py)
    end
end