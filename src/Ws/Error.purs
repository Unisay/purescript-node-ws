module Ws.Error where

import Custom.Prelude

import Data.String as String

data Code
  = WS_ERR_EXPECTED_FIN
  | WS_ERR_EXPECTED_MASK
  | WS_ERR_INVALID_CLOSE_CODE
  | WS_ERR_INVALID_CONTROL_PAYLOAD_LENGTH
  | WS_ERR_INVALID_OPCODE
  | WS_ERR_INVALID_UTF8
  | WS_ERR_UNEXPECTED_MASK
  | WS_ERR_UNEXPECTED_RSV_1
  | WS_ERR_UNEXPECTED_RSV_2_3
  | WS_ERR_UNSUPPORTED_DATA_PAYLOAD_LENGTH
  | WS_ERR_UNSUPPORTED_MESSAGE_LENGTH
  | WS_ERR_UNKNOWN String

readCode ∷ String → Code
readCode = case _ of
  "WS_ERR_EXPECTED_FIN" →
    WS_ERR_EXPECTED_FIN
  "WS_ERR_EXPECTED_MASK" →
    WS_ERR_EXPECTED_MASK
  "WS_ERR_INVALID_CLOSE_CODE" →
    WS_ERR_INVALID_CLOSE_CODE
  "WS_ERR_INVALID_CONTROL_PAYLOAD_LENGTH" →
    WS_ERR_INVALID_CONTROL_PAYLOAD_LENGTH
  "WS_ERR_INVALID_OPCODE" →
    WS_ERR_INVALID_OPCODE
  "WS_ERR_INVALID_UTF8" →
    WS_ERR_INVALID_UTF8
  "WS_ERR_UNEXPECTED_MASK" →
    WS_ERR_UNEXPECTED_MASK
  "WS_ERR_UNEXPECTED_RSV_1" →
    WS_ERR_UNEXPECTED_RSV_1
  "WS_ERR_UNEXPECTED_RSV_2_3" →
    WS_ERR_UNEXPECTED_RSV_2_3
  "WS_ERR_UNSUPPORTED_DATA_PAYLOAD_LENGTH" →
    WS_ERR_UNSUPPORTED_DATA_PAYLOAD_LENGTH
  "WS_ERR_UNSUPPORTED_MESSAGE_LENGTH" →
    WS_ERR_UNSUPPORTED_MESSAGE_LENGTH
  s → WS_ERR_UNKNOWN s

codeMessage ∷ Code → String
codeMessage = case _ of
  WS_ERR_EXPECTED_FIN →
    "A WebSocket frame was received with the FIN \
    \bit not set when it was expected."
  WS_ERR_EXPECTED_MASK →
    "An unmasked WebSocket frame was received by a WebSocket server."
  WS_ERR_INVALID_CLOSE_CODE →
    "A WebSocket close frame was received with an invalid close code."
  WS_ERR_INVALID_CONTROL_PAYLOAD_LENGTH →
    "A control frame with an invalid payload length was received."
  WS_ERR_INVALID_OPCODE →
    "A WebSocket frame was received with an invalid opcode."
  WS_ERR_INVALID_UTF8 →
    "A text or close frame was received containing invalid UTF-8 data."
  WS_ERR_UNEXPECTED_MASK →
    "A masked WebSocket frame was received by a WebSocket client."
  WS_ERR_UNEXPECTED_RSV_1 →
    "A WebSocket frame was received with the RSV1 bit set unexpectedly."
  WS_ERR_UNEXPECTED_RSV_2_3 →
    "A WebSocket frame was received with the RSV2 or RSV3 bit set unexpectedly."
  WS_ERR_UNSUPPORTED_DATA_PAYLOAD_LENGTH →
    "A data frame was received with a length longer than the max supported\
    \ length (2^53 - 1, due to JavaScript language limitations)."
  WS_ERR_UNSUPPORTED_MESSAGE_LENGTH →
    "A message was received with a length longer than the maximum\
    \ supported length, as configured by the maxPayload option."
  WS_ERR_UNKNOWN e →
    "Unrecognized WS error: " <> String.take 16 e

