{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
-- import Network.HTTP.Types.Status
import Database.Persist.Postgresql

getPage1R :: Handler Html
getPage1R = do
    defaultLayout $ do
        addStylesheet (StaticR css_bootstrap_css)
        toWidgetHead $(juliusFile "templates/page1.julius")
        toWidgetHead $(luciusFile "templates/page1.lucius")
        $(whamletFile "templates/page1.hamlet")

getHomeR :: Handler Html
getHomeR = do
    defaultLayout $ do
        -- remoto
        -- addScriptRemote "https://code.jquery.com.br"
        -- esta no projeto
        addStylesheet (StaticR css_bootstrap_css)
        toWidgetHead [julius|
            function ola(){
                alert("OLA MUNDO")
            }
        |]
        toWidgetHead [lucius|
            h1 {
                color: green;
            }
        |]
        [whamlet|
            <div>
                <h1>
                    OLA MUNDO
            <img src=@{StaticR citeg_png}>
            <button class="btn btn-danger" onclick="ola()">
                OK
        |]
