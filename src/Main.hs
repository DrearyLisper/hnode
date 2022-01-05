module Main where

import Control.Monad
import Control.Concurrent

import Network.HostName
import Network.Socket
import Network.Socket.ByteString
import qualified Data.ByteString.Char8 as C

main :: IO ()
main = do
  addrinfos <- getAddrInfo Nothing (Just "0.0.0.0") (Just "7000")
  let serveraddr = head addrinfos
  sock <- socket (addrFamily serveraddr) Datagram defaultProtocol
  bind sock (addrAddress serveraddr)
  setSocketOption sock ReuseAddr 1
  setSocketOption sock Broadcast 1
  print sock
  forkIO $ forever (do recv sock 4096 >>= print)
  forever $ do
    remoteAddrs <- getAddrInfo Nothing (Just "255.255.255.255") (Just "7000")
    hostname <- getHostName
    sendTo sock (C.pack hostname) (addrAddress $ head remoteAddrs)
    threadDelay 1000000
