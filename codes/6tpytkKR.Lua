local lightRadius = {}
  local lightPos = {}
  for i = 1, #worldLights do
    table.insert(lightRadius, worldLights[i].radius)
    table.insert(lightPos, {worldLights[i].x - cam.x + (worldLights[i].bound_x / 2),
                             worldLights[i].y - cam.y + (worldLights[i].bound_y / 2)})
  end

  lightShader:send("colourDay", colour)
  lightShader:send("lightCount", #worldLights)
  lightShader:send("radius", unpack(lightRadius))
  lightShader:send("lightPos", unpack(lightPos))