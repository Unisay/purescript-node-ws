module Ws.WebSocket
  ( WebSocket
  , readyState
  , ReadyState(..)
  , create
  , Address
  , Protocol
  , Options
  , onOpen
  , close
  , onClose
  , Reason
  , Code
  , onError
  , send
  , SendOpts
  , onMessage
  ) where

import Custom.Prelude

import Data.Nullable (Nullable, toNullable)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff, runEffectFn3)
import Effect.Uncurried (EffectFn2, EffectFn3, mkEffectFn2, runEffectFn2)
import Foreign (Foreign)
import Node.Buffer (Buffer)
import Node.Buffer.Immutable (ImmutableBuffer)
import Partial.Unsafe (unsafeCrashWith)
import Ws.Error as Error

data WebSocket

data ReadyState = Connecting | Open | Closing | Closed

foreign import _readyState ∷ WebSocket → Int

readyState ∷ WebSocket → ReadyState
readyState = _readyState >>> case _ of
  0 → Connecting
  1 → Open
  2 → Closing
  3 → Closed
  c → unsafeCrashWith $ "Unknown WS readyState constant: " <> show c

type Address = String
type Protocol = String
type Options =
  { followRedirects ∷ Boolean
  , handshakeTimeout ∷ Number
  , maxPayload ∷ Number
  , maxRedirects ∷ Number
  , origin ∷ String
  , protocolVersion ∷ Number
  , skipUTF8Validation ∷ Boolean
  }

foreign import _create
  ∷ EffectFn3 Address (Array Protocol) (Nullable Options) WebSocket

create ∷ Address → Array Protocol → Maybe Options → Effect WebSocket
create address protocols options =
  runEffectFn3 _create address protocols (toNullable options)

foreign import _onOpen
  ∷ EffectFn2 WebSocket (Effect Unit) Unit

onOpen ∷ WebSocket → Effect Unit → Effect Unit
onOpen ws cb = runEffectFn2 _onOpen ws cb

foreign import _onClose
  ∷ EffectFn2 WebSocket (EffectFn2 Number ImmutableBuffer Unit) Unit

type Reason = ImmutableBuffer
type Code = Number

foreign import _close
  ∷ EffectFn3 WebSocket Code String Unit

close ∷ WebSocket → Code → String → Effect Unit
close = runEffectFn3 _close

onClose ∷ WebSocket → (Code → Reason → Effect Unit) → Effect Unit
onClose ws cb = runEffectFn2 _onClose ws (mkEffectFn2 cb)

foreign import _onError
  ∷ EffectFn2 WebSocket ({ code ∷ String } → Effect Unit) Unit

onError ∷ WebSocket → (Error.Code → Effect Unit) → Effect Unit
onError ws cb = runEffectFn2 _onError ws (_.code >>> Error.readCode >>> cb)

foreign import _onMessage
  ∷ EffectFn2 WebSocket (EffectFn2 Buffer Boolean Unit) Unit

onMessage ∷ WebSocket → (Buffer → Boolean → Effect Unit) → Effect Unit
onMessage ws cb = runEffectFn2 _onMessage ws (mkEffectFn2 cb)

type SendOpts =
  { binary ∷ Boolean
  , compress ∷ Boolean
  , fin ∷ Boolean
  , mask ∷ Boolean
  }

foreign import _send
  ∷ WebSocket → Foreign → Nullable SendOpts → EffectFnAff Unit

send ∷ WebSocket → Foreign → Maybe SendOpts → Aff Unit
send ws a opts = fromEffectFnAff $ _send ws a (toNullable opts)

