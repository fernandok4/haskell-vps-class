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
    cards <- runDB $ selectList [Filter CardsNmCard (Left $ concat ["%", search, "%"]) (BackendSpecificFilter "ILIKE")] []
    defaultLayout $ do 
        addStylesheet (StaticR css_bootstrap_css)
        toWidgetHead $(juliusFile "templates/cards.julius")
        $(whamletFile "templates/cards.hamlet")