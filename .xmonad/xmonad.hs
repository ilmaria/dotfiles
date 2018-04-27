{-# LANGUAGE RebindableSyntax #-}
import XMonad.Config.Prime

import qualified XMonad as XM
import XMonad (XConfig, sendMessage)
import XMonad.Actions.CycleWS (prevWS, nextWS)
import XMonad.Actions.WindowNavigation (withWindowNavigation)
import XMonad.Hooks.DynamicLog (xmobar)
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Layout.Fullscreen (fullscreenSupport)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Tabbed (simpleTabbed)
import XMonad.Layout.Spacing (spacing, spacingWithEdge, incSpacing)

mySpacing = 15

main = xmonad $ do
    modMask =: mod4Mask
    normalBorderColor =: "#282828"
    focusedBorderColor =: "#ebdbb2"
    terminal =: "urxvt"
--    focusFollowsMouse =: False
    clickJustFocuses =: False
    applyIO $ xmobar
    resetLayout $ avoidStruts (spacingWithEdge mySpacing (Tall 1 (3/100) (1/2))) ||| Full
    modifyLayout smartBorders
    apply fullscreenSupport
    applyIO $ withWindowNavigation (xK_w, xK_a, xK_s, xK_d)
    keys =+ [
          ("M-2",                    spawn "firefox")
        , ("M-3",                    spawn "urxvt")
        , ("C-M1-a",                 spawn "keepass --auto-type")
        , ("M1-<F4>",                kill)
        , ("<XF86AudioRaiseVolume>", spawn "amixer sset Master 3%+")
        , ("<XF86AudioLowerVolume>", spawn "amixer sset Master 3%-")
        , ("M-<Right>",              nextWS)
        , ("M-<Left>",               prevWS)
        , ("M-<KP_Add>",             incSpacing (1))
        , ("M-<KP_Subtract>",        incSpacing (-1))
        ]
