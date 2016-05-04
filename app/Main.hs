{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
import           Prelude                (IO)
import           Data.Aeson
import           GHC.Generics
import           ClassyPrelude
import           Data.Text (Text)
import           Yesod

--initial example (getHomeR) from http://www.yesodweb.com/book/restful-content

--authentication examples from http://www.yesodweb.com/book/authentication-and-authorization
--yesod account authentication - https://hackage.haskell.org/package/yesod-auth-account-1.4.2/docs/Yesod-Auth-Account.html
--yesod blog example - http://www.yesodweb.com/book/blog-example-advanced



data Person = Person
    { name :: Text
    , age  :: Int
    }

instance ToJSON Person where
    toJSON Person {..} = object
        [ "name" .= name
        , "age"  .= age
        ]

data App = App

mkYesod "App" [parseRoutes|
/test           TestR GET
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
