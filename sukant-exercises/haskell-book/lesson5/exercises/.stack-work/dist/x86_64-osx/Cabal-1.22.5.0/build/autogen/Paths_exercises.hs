module Paths_exercises (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/hollygibson/github/code-exercises/sukant-exercises/haskell-book/lesson5/exercises/.stack-work/install/x86_64-osx/lts-5.13/7.10.3/bin"
libdir     = "/Users/hollygibson/github/code-exercises/sukant-exercises/haskell-book/lesson5/exercises/.stack-work/install/x86_64-osx/lts-5.13/7.10.3/lib/x86_64-osx-ghc-7.10.3/exercises-0.1.0.0-A4a6mfWpNWM9zh3SIBCHaX"
datadir    = "/Users/hollygibson/github/code-exercises/sukant-exercises/haskell-book/lesson5/exercises/.stack-work/install/x86_64-osx/lts-5.13/7.10.3/share/x86_64-osx-ghc-7.10.3/exercises-0.1.0.0"
libexecdir = "/Users/hollygibson/github/code-exercises/sukant-exercises/haskell-book/lesson5/exercises/.stack-work/install/x86_64-osx/lts-5.13/7.10.3/libexec"
sysconfdir = "/Users/hollygibson/github/code-exercises/sukant-exercises/haskell-book/lesson5/exercises/.stack-work/install/x86_64-osx/lts-5.13/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "exercises_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "exercises_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "exercises_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "exercises_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "exercises_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
