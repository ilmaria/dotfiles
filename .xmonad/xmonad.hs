{-# LANGUAGE RebindableSyntax #-}
import XMonad.Config.Prime

import qualified XMonad as XM
import XMonad (XConfig, xK_e)
import XMonad.Actions.CycleWS (prevWS, nextWS)
import XMonad.Actions.SwapWorkspaces (swapWithCurrent)
import XMonad.Actions.WindowNavigation (withWindowNavigation)
import XMonad.Hooks.DynamicLog (statusBar, xmobarPP, xmobarColor, wrap, ppCurrent)
import XMonad.Layout.Fullscreen (fullscreenSupport)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Tabbed (simpleTabbed)

main = xmonad $ do
    modMask =: mod4Mask
    normalBorderColor =: "#282828"
    focusedBorderColor =: "#ebdbb2"
    terminal =: "urxvt"
--    focusFollowsMouse =: False
    clickJustFocuses =: False
    resetLayout $ Tall 1 (3/100) (1/2) ||| Full
    modifyLayout smartBorders
    apply fullscreenSupport
    applyIO $ withWindowNavigation (xK_w, xK_a, xK_s, xK_d)
    applyIO $ statusBar "xmobar" statusPP toggleStatusKey
    keys =+ [
        ("M-2",                    spawn "firefox"),
        ("M-3",                    spawn "urxvt"),
        ("C-M1-a",                 spawn "keepass --auto-type"),
        ("M1-<F4>",                kill),
        ("<XF86AudioRaiseVolume>", spawn "amixer sset Master 5%+"),
        ("<XF86AudioLowerVolume>", spawn "amixer sset Master 5%-"),
        ("M-<Right>",              nextWS),
        ("M-<Left>",               prevWS)
        ]

statusPP = xmobarPP {
    ppCurrent = xmobarColor "#429942" "" . wrap "<" ">"
}

toggleStatusKey XConfig {XM.modMask = modMaskKey} =
    (modMaskKey, xK_e)

