module Main (main) where

import System.IO (stdin)
import qualified Data.Attoparsec.ByteString as P
import qualified Data.ByteString as B


main :: IO ()
main =
    do
    chunk <- B.hGet stdin 100
    mainHelp $ P.parse (P.takeByteString >> return ()) chunk


mainHelp :: P.IResult B.ByteString () -> IO ()
mainHelp result =
    case result of
    P.Partial partial ->
        do
        chunk <- B.hGet stdin 100
        mainHelp $ partial chunk

    _ ->
        putStrLn "Done or failed"
