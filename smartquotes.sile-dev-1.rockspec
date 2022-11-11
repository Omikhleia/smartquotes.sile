package = "smartquotes.sile"
version = "dev-1"
source = {
  url = "git://github.com/Omikhleia/smartquotes.sile.git",
}
description = {
  summary = "Typographic quotation marks with the SILE typesetting system.",
  detailed = [[
    This package for the SILE typesetter helps obtaining appropriate typographic quotation marks,
    depending on the current language.
  ]],
  homepage = "https://github.com/Omikhleia/smartquotes.sile",
  license = "MIT",
}
dependencies = {
  "lua >= 5.1",
}
build = {
  type = "builtin",
  modules = {
    ["sile.packages.smartquotes"] = "packages/smartquotes/init.lua",
  }
}
