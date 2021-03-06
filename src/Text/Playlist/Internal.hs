--------------------------------------------------------------------------------
{- This file is part of the xmonadrc package. It is subject to the
license terms in the LICENSE file found in the top-level directory of
this distribution and at git://pmade.com/xmonadrc/LICENSE. No part of
the xmonadrc package, including this file, may be copied, modified,
propagated, or distributed except according to the terms contained in
the LICENSE file. -}

--------------------------------------------------------------------------------
module Text.Playlist.Internal
       ( Stream (..)
       , Playlist
       , Title
       , URL
       , playlistTitles
       , playlistLookup
       ) where

--------------------------------------------------------------------------------
import Data.Text (Text)

--------------------------------------------------------------------------------
type Title = Text -- ^ Stream title/name.
type URL   = Text -- ^ URL for the stream.

--------------------------------------------------------------------------------
-- | An Internet radio station or music stream is basically just a
-- title and URL.
data Stream = Stream Title URL deriving (Show)

--------------------------------------------------------------------------------
-- | A playlist is a list of streams to play or choose from.
type Playlist = [Stream]

--------------------------------------------------------------------------------
-- | Return a list stream tiles that are part of the playlist.
playlistTitles :: Playlist -> [Text]
playlistTitles = map $ \(Stream t _) -> t

--------------------------------------------------------------------------------
-- | Look up a stream's URL in a playlist.
playlistLookup :: Playlist -> Title -> Maybe URL
playlistLookup plist title = lookup title (map (\(Stream t u) -> (t, u)) plist)
