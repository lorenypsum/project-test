{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_project_test (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/loren/haskell-projects/project-test/.stack-work/install/x86_64-linux/eef43f1ef54c332004eb5765c738fb09c3a56b919c69f1c23826238b968cfa4b/9.4.5/bin"
libdir     = "/home/loren/haskell-projects/project-test/.stack-work/install/x86_64-linux/eef43f1ef54c332004eb5765c738fb09c3a56b919c69f1c23826238b968cfa4b/9.4.5/lib/x86_64-linux-ghc-9.4.5/project-test-0.1.0.0-5FuofeeZnBh6LLrvalnarn-project-test"
dynlibdir  = "/home/loren/haskell-projects/project-test/.stack-work/install/x86_64-linux/eef43f1ef54c332004eb5765c738fb09c3a56b919c69f1c23826238b968cfa4b/9.4.5/lib/x86_64-linux-ghc-9.4.5"
datadir    = "/home/loren/haskell-projects/project-test/.stack-work/install/x86_64-linux/eef43f1ef54c332004eb5765c738fb09c3a56b919c69f1c23826238b968cfa4b/9.4.5/share/x86_64-linux-ghc-9.4.5/project-test-0.1.0.0"
libexecdir = "/home/loren/haskell-projects/project-test/.stack-work/install/x86_64-linux/eef43f1ef54c332004eb5765c738fb09c3a56b919c69f1c23826238b968cfa4b/9.4.5/libexec/x86_64-linux-ghc-9.4.5/project-test-0.1.0.0"
sysconfdir = "/home/loren/haskell-projects/project-test/.stack-work/install/x86_64-linux/eef43f1ef54c332004eb5765c738fb09c3a56b919c69f1c23826238b968cfa4b/9.4.5/etc"

getBinDir     = catchIO (getEnv "project_test_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "project_test_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "project_test_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "project_test_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "project_test_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "project_test_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
