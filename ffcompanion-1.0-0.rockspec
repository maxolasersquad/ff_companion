package = "FFCompanion"
rockspec_format = "3.0"
version = "1.0-0"
source = {
  url = "https://github.com/maxolasersquad/ff_companion",
  tag = "v1.0"
}
description = {
  summary = "Final Fantasy companion app for FCEUX",
  detailed = [[
    This is a lua script for FCEUX that provides and object-oriented view into the Final Fantasy game.
  ]],
  homepage = "https://github.com/maxolasersquad/ff_companion",
  license = "GNU"
}
dependencies = {
  "bit32 >= 5.3",
  "lgi >= 0.9"
}
