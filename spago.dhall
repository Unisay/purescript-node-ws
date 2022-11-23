{ name = "purescript-node-ws"
, dependencies =
  [ "aff"
  , "avar"
  , "console"
  , "custom-prelude"
  , "effect"
  , "foreign"
  , "node-buffer"
  , "nullable"
  , "partial"
  , "spec"
  , "strings"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
