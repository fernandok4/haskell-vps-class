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

getPage2R :: Handler Html
getPage2R = do
    defaultLayout $ do
        addStylesheet (StaticR css_bootstrap_css)
        $(whamletFile "templates/page2.hamlet")

getPage1R :: Handler Html
getPage1R = do
    defaultLayout $ do
        addStylesheet (StaticR css_bootstrap_css)
        toWidgetHead $(julius "templates/page1.julius")
        toWidgetHead $(lucius "templates/page1.lucius")
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
            
            ul {
                display: inline;
                list-style: none;
            }
        |]
        [whamlet|
            <div>
                <h1>
                    OLA MUNDO
            <ul>
                <li>
                    <a href=@{Page1R}>
                        Pagina 1
                <li>
                    <a href=@{Page2R}>
                        Pagina 2
                        
            <img src=@{StaticR citeg_png}>
            <button class="btn btn-danger" onclick="ola()">
                OK
        |]
