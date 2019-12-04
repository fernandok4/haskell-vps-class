{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.CardPrice where

import Import
import Database.Persist.Postgresql
import Prelude
import Text.Julius

getPrices :: CardsId -> Handler Html
getPrices cardid = do
    sess <- lookupSession "_ID"
    case sess of 
        Nothing -> redirect Register
        Just _ -> do 
            let sql = "SELECT DISTINCT ON (cards.id_card, cards_price.id_site) ??, ?? FROM cards \
                  \ INNER JOIN cards_price ON cards.id_card = cards_price.id_card \
                  \ WHERE cards.id_card = ? \
                  \ ORDER BY cards.id_card, cards_price.id_site, cards_price.dt_reference DESC"
            card <- runDB $ get404 cardid
            valores <- runDB $ rawSql sql [toPersistValue cardid] :: Handler [(Entity Cards, Entity CardPrice)]
            defaultLayout $ do 
                toWidgetHead $(juliusFile "templates/cardprice.julius")
                [whamlet|
                    <h1>
                        #{cardsNmCard card}
                    <img src="/static/#{cardsIdCard card}.jpg" style="width: 400px;">
                    <ul>
                        $forall (Entity _ _, Entity _ precos) <- valores
                            <li>
                                #{cardPriceVlPrice precos}
                    <input type="button" onclick="addCard(#{cardsIdCard card})" value="clica ai mano">
                    <a href="/home">
                        Voltar
                |]

postAddCard :: CardsId -> Handler Html
postAddCard cardid = do
    sess <- lookupSession "_ID"
    case sess of 
        Nothing -> redirect HomeR
        Just _ -> do 
            idusuario <- lookupSession "_ID"
            case idusuario of
                Nothing -> redirect HomeR
                Just a -> do
                    runDB $ insert (CardUsuario a cardid)
                    redirect Search
            