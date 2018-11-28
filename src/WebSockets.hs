{-# LANGUAGE EmptyDataDecls #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RebindableSyntax #-}
module WebSockets where

import Data.Text
import FFI
import Prelude

data WebSocket
data WSEvent

data WSState = Connecting | Open | Closing | Closed

getWsUrl :: Fay Text
getWsUrl = ffi "window['location']['href'].replace('http:', 'ws:').replace('https:', 'wss:')"

onOpen :: WSEvent -> Fay ()
onOpen = ffi "console.log('WebSocket is up and running')"

onClose :: WebSocket -> Fay f -> Fay ()
onClose = ffi "%1.onclose=%2"

onError :: WebSocket -> Fay f -> Fay ()
onError = ffi "%1.onerror=%2"

eventData :: WSEvent -> Fay Text
eventData = ffi "%1['data']"

onMessage :: WSEvent -> Fay ()
onMessage = ffi "(function(e){console.log(e); console.log(e.data);})(%1)"

websocket
  :: Text -- ^ URL
  -> (WSEvent -> Fay ()) -- ^ .onopen
  -> (WSEvent -> Fay ()) -- ^ .onmessage
  -> (WSEvent -> Fay ()) -- ^ .onerror
  -> (WSEvent -> Fay ()) -- ^ .onclose
  -> Fay WebSocket
websocket = ffi "(function (){var conn = new WebSocket(%1);\
\ conn.onopen = %2, conn.onmessage = %3, conn.onerror = %4, conn.onclose = %5;\  
\return conn})()"

-- FIXME: add 'USVString', 'ArrayBuffer', 'Blob', 'ArrayBufferView'
sendWS :: WebSocket -> Text -> Fay ()
sendWS = ffi "%1.send(%2)"

close :: WebSocket -> Fay ()
close = ffi "%1.close"
