{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Text.Lucius
import Text.Julius
-- import Network.HTTP.Types.Status
import Database.Persist.Postgresql

getHomeR :: Handler Html
getHomeR = do
    defaultLayout $ do
        -- remoto
        -- addScriptRemote "https://code.jquery.com.br"
        -- esta no projeto
        addStylesheet (StaticR css_bootstrap_css)
        toWidgetHead $(juliusFile "templates/homepage.julius")
        toWidgetHead $(luciusFile "templates/homepage.lucius")
        $(whamletFile "templates/homepage.hamlet")


