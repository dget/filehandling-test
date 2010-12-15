module Paths_filehandletest2 (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import Data.Version (Version(..))
import System.Environment (getEnv)

version :: Version
version = Version {versionBranch = [0,1], versionTags = []}

bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/Users/dan/.cabal/bin"
libdir     = "/Users/dan/.cabal/lib/filehandletest2-0.1/ghc-6.12.3"
datadir    = "/Users/dan/.cabal/share/filehandletest2-0.1"
libexecdir = "/Users/dan/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catch (getEnv "filehandletest2_bindir") (\_ -> return bindir)
getLibDir = catch (getEnv "filehandletest2_libdir") (\_ -> return libdir)
getDataDir = catch (getEnv "filehandletest2_datadir") (\_ -> return datadir)
getLibexecDir = catch (getEnv "filehandletest2_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
