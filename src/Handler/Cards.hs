{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Cards where

import Import
import Text.Julius
import Database.Persist.Postgresql

getSearch :: Handler Html
getSearch = getSearchCards ""

getSearchCards :: Text -> Handler Html
getSearchCards search = do
    sess <- lookupSession "_ID"
    case sess of 
        Nothing -> redirect Register
        Just _ -> do
            cards <- runDB $ selectList [Filter CardsNmCard (Left $ concat ["%", search, "%"]) (BackendSpecificFilter "ILIKE")] []
            defaultLayout $ do 
                addStylesheetRemote "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
                toWidgetHead $(juliusFile "templates/homepage.julius")
                toWidgetHead $(juliusFile "templates/cards.julius")
                $(whamletFile "templates/cards.hamlet")