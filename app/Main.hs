module Main where

import System.Info (fullCompilerVersion)
import Data.Version (showVersion)
import GHC.Stack (CallStack, SrcLoc (..), callStack, getCallStack)

import RequireCallStack (RequireCallStack, provideCallStack)

main :: IO ()
main = do
    putStrLn $ "Running in GHC " <> showVersion fullCompilerVersion
    provideCallStack (run outer)

inner :: RequireCallStack => IO ()
inner = run $ pure ()

outer :: RequireCallStack => IO ()
outer = run inner

run ::
  RequireCallStack =>
  IO a ->
  IO a
run action = do
  let context = getLoggingContext callStack
  putStrLn "============================================================"
  putStrLn context
  action

getLoggingContext :: CallStack -> String
getLoggingContext s =
    unlines $ map prettyEntry (getCallStack s)
  where
    prettyEntry (name, loc) =
      name
      <> ", called at "
      <> show (srcLocStartLine loc)
      <> ":"
      <> show (srcLocStartCol loc)
