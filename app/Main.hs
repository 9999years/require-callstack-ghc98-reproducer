{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE ImplicitParams #-}

module Main where

import System.Info (fullCompilerVersion)
import Data.Version (showVersion)
import GHC.Stack (HasCallStack, CallStack, SrcLoc (..), callStack, getCallStack)

main :: IO ()
main = do
  putStrLn $ "Running in GHC " <> showVersion fullCompilerVersion
  run outer
  where
    ?myImplicitParam = ()

inner :: (HasCallStack, ?myImplicitParam :: ()) => IO ()
inner = run $ pure ()

outer :: (HasCallStack, ?myImplicitParam :: ()) => IO ()
outer = run inner

run ::
  (HasCallStack, ?myImplicitParam :: ()) =>
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
