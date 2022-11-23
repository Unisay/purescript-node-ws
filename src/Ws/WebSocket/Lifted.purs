module Ws.WebSocket.Lifted where

import Custom.Prelude

import Effect (Effect)
import Effect.Class (class MonadEffect, liftEffect)
import Node.Buffer (Buffer)
import Ws.Error as Error
import Ws.WebSocket as WS

create
  ∷ ∀ m
  . MonadEffect m
  ⇒ WS.Address
  → Array WS.Protocol
  → Maybe WS.Options
  → m WS.WebSocket
create address protocols options =
  liftEffect $ WS.create address protocols options

onOpen ∷ ∀ m. MonadEffect m ⇒ WS.WebSocket → Effect Unit → m Unit
onOpen ws cb = liftEffect $ WS.onOpen ws cb

close ∷ ∀ m. MonadEffect m ⇒ WS.WebSocket → WS.Code → String → m Unit
close ws code reason = liftEffect $ WS.close ws code reason

onClose
  ∷ ∀ m
  . MonadEffect m
  ⇒ WS.WebSocket
  → (WS.Code → WS.Reason → Effect Unit)
  → m Unit
onClose ws cb = liftEffect $ WS.onClose ws cb

onError
  ∷ ∀ m
  . MonadEffect m
  ⇒ WS.WebSocket
  → (Error.Code → Effect Unit)
  → m Unit
onError ws cb = liftEffect $ WS.onError ws cb

onMessage
  ∷ ∀ m
  . MonadEffect m
  ⇒ WS.WebSocket
  → (Buffer → Boolean → Effect Unit)
  → m Unit
onMessage ws cb = liftEffect $ WS.onMessage ws cb
