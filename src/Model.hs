{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
module Model where

import ClassyPrelude.Yesod
import Database.Persist.Quasi

-- You can define all of your database entities in the entities file.
-- You can find more information on persistent and how to declare entities
-- at:
-- http://www.yesodweb.com/book/persistent/
share [mkPersist sqlSettings, mkMigrate "migrateAll"]
    $(persistFileWith lowerCaseSettings "config/models")

instance ToJSON (Entity Cards) where
    toJSON (Entity pid p) = object
        [ 
            "name"   .= cardsNmCard p,
            "attribute" .= cardsNmAttribute p,
            "image" .= cardsDsUrlCard p
        ]

instance ToJSON (Entity CardPrice) where
    toJSON (Entity pid p) = object
        [ 
            "vl_price"   .= cardPriceVlPrice p,
            "attribute" .= cardPriceIdSite p
        ]