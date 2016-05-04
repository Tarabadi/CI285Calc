{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
--{-# LANGUAGE GADTs                      #-}
--{-# LANGUAGE FlexibleContexts           #-}
--{-# LANGUAGE MultiParamTypeClasses      #-}
--{-# LANGUAGE DeriveDataTypeable         #-}
--{-# LANGUAGE GeneralizedNewtypeDeriving #-}
--{-# LANGUAGE ViewPatterns               #-}
import           Prelude                (IO)
import           Data.Aeson
import           GHC.Generics
import           ClassyPrelude
import           Data.Text (Text)
import           Yesod


--import           Yesod.Auth
--import           Yesod.Form.Nic (YesodNic, nicHtmlField)
--import           Yesod.Auth.BrowserId (authBrowserId, def)
--import           Data.Text (Text)
--import           Network.HTTP.Client.TLS (tlsManagerSettings)
--import           Network.HTTP.Conduit (Manager, newManager)
--import           Database.Persist.Sqlite
--                 ( ConnectionPool, SqlBackend, runSqlPool, runMigration
--                 , createSqlitePool, runSqlPersistMPool
--                 )
--import           Data.Time (UTCTime, getCurrentTime)
--import           Control.Applicative ((<$>), (<*>), pure)
--import           Data.Typeable (Typeable)
--import           Control.Monad.Logger (runStdoutLoggingT)

--initial example (getHomeR) from http://www.yesodweb.com/book/restful-content

--authentication examples at http://www.yesodweb.com/book/authentication-and-authorization
--yesod account authentication - https://hackage.haskell.org/package/yesod-auth-account-1.4.2/docs/Yesod-Auth-Account.html
--yesod blog example - http://www.yesodweb.com/book/blog-example-advanced
--using http://www.yesodweb.com/book/authentication-and-authorization exampele of google api to figure out auth

--look at https://hackage.haskell.org/package/yesod-auth-hashdb-1.5.1/docs/Yesod-Auth-HashDB.html
--create sqlite database with usernames, passwords, if logged in doing an equation will write to the
--"history" section of the table

--ask if use will be entirely terminal or through a browser (html forms for logging in, etc)

share [mkPersist sqlSettings, mkMigrate "migrateAll"]
[persistLowerCase|

User
    email Text
    UniqueUser email
    deriving Typeable

Calculation
    equation Text
    answer Text
|]


data Person = Person
    { name :: Text
    , age  :: Int
    }

instance ToJSON Person where
    toJSON Person {..} = object
        [ "name" .= name
        , "age"  .= age
        ]

--added connPool/httpManager
data App = App
    { connPool    :: ConnectionPool
    , httpManager :: Manager
    }


mkYesod "App" [parseRoutes|
/test           TestR GET
/auth           AuthR Auth getAuth
/add/#Int/#Int  AddR  GET
/sub/#Int/#Int  SubR  GET
/mult/#Int/#Int MultR GET
/div/#Int/#Int  DivR  GET
|]

instance Yesod App

getHomeR :: Handler TypedContent
getHomeR = selectRep $ do
    provideRep $ return
        [shamlet|
            <p>Hello, my name is #{name} and I am #{age} years old.
        |]
    provideJson person
  where
    person@Person {..} = Person "Johnny" 35

getTestR :: Handler TypedContent
getTestR = selectRep $ do
    provideRep $ return
        [shamlet|
            <p>Connection Successful!
        |]


getAddR :: Int -> Int -> Handler TypedContent
getAddR x y = selectRep $ do
    provideRep $ return
        [shamlet|
            <p>#{ans}
        |]
    provideJson ans
  where
    ans = x + y

getSubR :: Int -> Int -> Handler TypedContent
getSubR x y = selectRep $ do
    provideRep $ return
        [shamlet|
            <p>#{ans}
        |]
    provideJson ans
  where
    ans = x - y

getMultR :: Int -> Int -> Handler TypedContent
getMultR x y = selectRep $ do
    provideRep $ return
        [shamlet|
            <p>#{ans}
        |]
    provideJson ans
  where
    ans = x * y

getDivR :: Int -> Int -> Handler TypedContent
getDivR x y = selectRep $ do
    provideRep $ return
        [shamlet|
            <p>#{ans}
        |]
    provideJson ans
  where
    ans = x `div` y


















main :: IO ()
main = warp 3000 App
