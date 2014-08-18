{-# OPTIONS -fno-warn-missing-signatures #-}

--------------------------------------------------------------------------------
{- This file is part of the xmonadrc package. It is subject to the
license terms in the LICENSE file found in the top-level directory of
this distribution and at git://pmade.com/xmonadrc/LICENSE. No part of
the xmonadrc package, including this file, may be copied, modified,
propagated, or distributed except according to the terms contained in
the LICENSE file. -}

--------------------------------------------------------------------------------
-- | Layout configuration and hook.
module XMonad.Local.Layout (layoutHook) where

--------------------------------------------------------------------------------
import XMonad hiding ((|||), layoutHook, float)
import XMonad.Config.Desktop
import XMonad.Layout.FixedColumn
import XMonad.Layout.Fullscreen
import XMonad.Layout.Grid
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Magnifier
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Reflect
import XMonad.Layout.ResizableTile
import XMonad.Layout.ToggleLayouts

myTile = named "Tall" $ ResizableTall 1 (3/100) (1/2) []
myCode = named "Coding" $ magnifiercz' 1.2 $ FixedColumn 1 1 80 10
myWide = named "On Top" $ Mirror myTile
myWideFlip = named "On Bottom" $ reflectVert $ myWide
myAllWindows = named "All Windows" $ noBorders (fullscreenFull Grid)
noTitles l = desktopLayoutModifiers l

myLayouts = smartBorders $ noTitles
        $ onWorkspace "code" codeLayouts
        $ allLayouts
    where
        allLayouts = myTile ||| myWide ||| myWideFlip ||| Full
        codeLayouts = myCode ||| myTile ||| myWide ||| myWideFlip ||| Full

layoutHook = toggleLayouts myAllWindows myLayouts
