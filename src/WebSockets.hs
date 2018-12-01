{-# LANGUAGE EmptyDataDecls #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RebindableSyntax #-}
module WebSockets where

import Data.Text
import FFI

-- | WebSocket object to keep connection, handle events and sending data.
data WebSocket

-- | WebSocket event.
data WSEvent

-- | State of WebSocket
data WSState = Connecting | Open | Closing | Closed

-- | Get current url and replace 'http' with 'ws'.
getWsUrl :: Fay Text
getWsUrl = ffi "window['location']['href'].replace('http:', 'ws:').replace('https:', 'wss:')"

-- | Wrapper over '.onopen' event.
onOpen :: WSEvent -> Fay ()
onOpen = ffi "console.log('WebSocket is up and running')"

-- | Wrapper over '.onclose' event.
onClose :: WebSocket -> Fay f -> Fay ()
onClose = ffi "%1.onclose=%2"

-- | Wrapper over '.onError' event.
onError :: WebSocket -> Fay f -> Fay ()
onError = ffi "%1.onerror=%2"

-- | Get text data from event.
eventData :: WSEvent -> Fay Text
eventData = ffi "%1['data']"

-- | Wrapper over '.onMessage'
onMessage :: WSEvent -> Fay ()
onMessage = ffi "(function(e){console.log(e); console.log(e.data);})(%1)"

-- | Key function that by given URL initialize connection, starts to listen all events and ready to sending data.
websocket
  :: Text -- ^ WebSocket endpoint URL;
  -> (WSEvent -> Fay ()) -- ^ when connection opened ;
  -> (WSEvent -> Fay ()) -- ^ when messages received;
  -> (WSEvent -> Fay ()) -- ^ when errors occured;
  -> (WSEvent -> Fay ()) -- ^ when connection closed.
  -> Fay WebSocket
websocket = ffi "(function (){var conn = new WebSocket(%1);\
\ conn.onopen = %2, conn.onmessage = %3, conn.onerror = %4, conn.onclose = %5;\  
\return conn})()"

-- FIXME: add 'USVString', 'ArrayBuffer', 'Blob', 'ArrayBufferView'
-- | Send text data over WebSocket.
sendWS :: WebSocket -> Text -> Fay ()
sendWS = ffi "%1.send(%2)"

-- | Close current connection.
close :: WebSocket -> Fay ()
close = ffi "%1.close"

-- | Get @'WebSocket'@ from @'WSEvent'@.
target :: WSEvent -> Fay WebSocket
target = ffi "%1['target']"
