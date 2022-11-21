let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.4-20221120/packages.dhall
        sha256:b14c3d5c9d32f5fd92bee0b81e087f73f7f7d3ffc6089ca20446f1d00c06311f

let overrides = {=}

let additions =
      { custom-prelude =
        { dependencies = [ "debug", "either", "maybe", "prelude", "strings" ]
        , repo = "https://github.com/Unisay/purescript-custom-prelude.git"
        , version = "v1.3.0"
        }
      }

in  upstream // overrides // additions
