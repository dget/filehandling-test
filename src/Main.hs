{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Applicative
import           Snap.Types
import           Snap.Util.FileServe
import           Snap.Http.Server

import qualified Data.ByteString.Char8 as S
import           Snap.Util.FileHandler

main :: IO ()
main = quickHttpServe $
    ifTop (writeBS "hello world") <|>
    route [ ("foo", writeBS "bar")
          , ("echo/:echoparam", echoHandler)
          , ("/testform/"  , method POST testForm)
          ] <|>
    dir "static" (fileServe ".")

echoHandler :: Snap ()
echoHandler = do
    param <- getParam "echoparam"
    maybe (writeBS "must specify echo/param in URL")
          writeBS param

------------------------------------------------------------------------------
-- Prints out the form submitted
testForm :: Snap ()
testForm = do
    writeBS $ "body"
    files <- handleFileUpload testHandler
    writeBS $ S.pack $ show files
    req <- getRequest
    writeBS $ S.pack $ show $ rqParams req