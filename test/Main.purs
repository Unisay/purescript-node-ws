module Test.Main where

import Custom.Prelude

import Effect (Effect)
import Effect.AVar as EVar
import Effect.Aff (launchAff_)
import Effect.Aff.AVar as AVar
import Effect.Class.Console (logShow)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (runSpec)
import Ws.WebSocket.Lifted as WS

main ∷ Effect Unit
main = launchAff_ $ runSpec [ consoleReporter ] do
  describe "Web socket" do
    it "is created and opened" do
      var ← AVar.empty
      ws ← WS.create "wss://echo.websocket.events" [] Nothing
      WS.onOpen ws do join $ EVar.put true var putCallback
      AVar.take var >>= shouldEqual true

modify ∷ ∀ a. EVar.AVar a → (a → a) → Effect Unit
modify var f = do
  join $ EVar.take var case _ of
    Left error → logShow error
    Right a → join $ EVar.put (f a) var putCallback

putCallback ∷ ∀ a b. Show a ⇒ Either a b → Effect Unit
putCallback = case _ of
  Left error → logShow error
  Right _unit → pass
