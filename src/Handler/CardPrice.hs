{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.CardPrice where

import Import
import Database.Persist.Postgresql

getPrices :: CardsId -> Handler Html
getPrices cardid = do 
    let sql = "SELECT DISTINCT ON (cards.id_card, cards_price.id_site) ??, ?? FROM cards \
          \ INNER JOIN cards_price ON cards.id_card = cards_price.id_card \
          \ WHERE cards.id_card = ? \
          \ ORDER BY cards.id_card, cards_price.id_site, cards_price.dt_reference DESC"
    card <- runDB $ get404 cardid
    valores <- runDB $ rawSql sql [toPersistValue cardid] :: Handler [(Entity Cards, Entity CardPrice)]
    defaultLayout $ do 
        [whamlet|
            <h1>
                #{cardsNmCard card}
            <img src="/static/#{cardsIdCard card}.jpg" style="width: 400px;">
            <ul>
                $forall (Entity _ _, Entity _ precos) <- valores
                    <li>
                        #{cardPriceVlPrice precos}
            <a href="/">
                Voltar
        |]