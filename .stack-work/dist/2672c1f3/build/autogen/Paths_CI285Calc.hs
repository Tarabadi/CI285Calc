module Paths_CI285Calc (
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

bindir     = "C:\\Users\\Matt\\CI285Calc\\.stack-work\\install\\789b972d\\bin"
libdir     = "C:\\Users\\Matt\\CI285Calc\\.stack-work\\install\\789b972d\\lib\\x86_64-windows-ghc-7.10.3\\CI285Calc-0.1.0.0-8Pp6f00uy2TFWZTaaldORw"
datadir    = "C:\\Users\\Matt\\CI285Calc\\.stack-work\\install\\789b972d\\share\\x86_64-windows-ghc-7.10.3\\CI285Calc-0.1.0.0"
libexecdir = "C:\\Users\\Matt\\CI285Calc\\.stack-work\\install\\789b972d\\libexec"
sysconfdir = "C:\\Users\\Matt\\CI285Calc\\.stack-work\\install\\789b972d\\etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "CI285Calc_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "CI285Calc_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "CI285Calc_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "CI285Calc_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "CI285Calc_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
