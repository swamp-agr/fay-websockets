# fay-websockets

[![Build Status](https://travis-ci.org/swamp-agr/fay-websockets.svg?branch=master)](https://travis-ci.org/swamp-agr/fay-websockets)

A FFI Wrapper for WebSockets use with Fay. It includes functions for WebSockets connection initialization, handling WebSockets events and sending data over WebSockets.

## Installation

With cabal:

```
cabal new-install fay-websockets
```

With stack:

```
stack build
```

Or just include `fay-websockets` in either your `.cabal` file or `package.yml`.

Then include it at the top of Fay file:

```
import WebSockets
```

2018 (c) Andrey Prokopenko