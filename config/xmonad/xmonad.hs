import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)

import XMonad.Hooks.ManageDocks (avoidStruts, docks)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.WallpaperSetter

import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing (Border (..), spacingRaw)
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.ResizableTile

import qualified XMonad.StackSet as W

import XMonad.Actions.Submap (submap)
import XMonad.Actions.FloatKeys (keysResizeWindow)

import Data.Bool (bool)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map

myLayoutHook = let myGaps = 7
               in mkToggle (single FULL)
                    $ avoidStruts
                    $ spacingRaw False (Border 0 myGaps 0 myGaps) True (Border myGaps 0 myGaps 0) True
                    $ ResizableTall 1 (2/100) (1/2) []

myWorkspaces :: [(String, WorkspaceId)]
myWorkspaces =
    [ ("&", "dev")
    , ("é", "chat")
    , ("\"", "school")
    , ("'", "misc")
    , ("(", "5")
    , ("-", "6")
    , ("è", "7")
    , ("_", "8")
    , ("ç", "9")
    , ("à", "0")
    ]

myWorkspaceKeymap =
    [ ("M-" ++ m ++ k, windows $ f i)
      | (i, k) <- zip workspaceNames mainKeys,
        (f, m) <- [ (W.greedyView, ""), (W.shift, "S-"), (shiftFocus, "M1-") ]
    ]
    where
      (mainKeys, workspaceNames) = unzip myWorkspaces
      shiftFocus i = W.greedyView i . W.shift i

myLogHook = wallpaperSetter defWallpaperConf {
                                wallpapers = defWPNamesJpg (map snd myWorkspaces)
                                    <> WallpaperList [("dev", WallpaperFix "~/.wallpapers/nixos-wallpaper-light.jpg")]
                            }
myTerminal = "alacritty"

myKeys :: XConfig a -> [(String, X ())]
myKeys c =
    [
    -- M-
      ("M-<Space>", spawn (terminal c))
    , ("M-p", spawn "dmenu_run -fn 'Pragmata Pro:size=10' -nb '#232323' -nf '#C5C5C5' -sb '#2F2F2F' -sf '#FFFFFF' -p 'find:'")
    , ("M-k", withFocused killWindow)
    
    -- Resizing
    , ("M-<L>", withFocused resizeLeft) 
    , ("M-<R>", withFocused resizeRight)
    , ("M-<U>", withFocused resizeTop)
    , ("M-<D>", withFocused resizeBottom)

    -- Special
    , ("<Print>", spawn "flameshot gui")

    -- Audio
    , ("<XF86AudioRaiseVolume>", spawn "pamixer -u && pamixer -i 2")
    , ("<XF86AudioLowerVolume>", spawn "pamixer -u && pamixer -d 2")
    , ("<XF86AudioMute>", spawn "pamixer -m")

    -- Keyboard
    , ("<XF86KbdBrightnessUp>", spawn "brightnessctl --device 'asus::kbd_backlight' s 1+")
    , ("<XF86KbdBrightnessDown>", spawn "brightnessctl --device 'asus::kbd_backlight' s 1-")

    -- Screen
    , ("<XF86MonBrightnessUp>", spawn "brightnessctl s 5%+")
    , ("<XF86MonBrightnessDown>", spawn "brightnessctl s 5%-")
    ] <> myWorkspaceKeymap
    where
      resizeLeft win   = isFloating win >>= bool (sendMessage Shrink) (keysResizeWindow (-5, 0) (0, 0) win) 
      resizeRight win  = isFloating win >>= bool (sendMessage Expand) (keysResizeWindow (5, 0) (0, 0) win)
      resizeTop win    = isFloating win >>= bool (sendMessage MirrorExpand) (keysResizeWindow (0, -5) (0, 0) win)
      resizeBottom win = isFloating win >>= bool (sendMessage MirrorShrink) (keysResizeWindow (0, 5) (0, 0) win)

isFloating :: Window -> X Bool
isFloating win = gets (Map.member win . W.floating . windowset)

main = do
    h <- spawnPipe "xmobar ./xmobar.hs"
    xmonad $ ewmhFullscreen $ ewmh $ docks $ def
        { borderWidth        = 2
        , terminal           = myTerminal
        , normalBorderColor  = "#b3b3b3"
        , focusedBorderColor = "#ae77be"
        , layoutHook         = myLayoutHook
        , logHook            = myLogHook
        , keys               = \ c -> mkKeymap c (myKeys c)
        , workspaces         = snd <$> myWorkspaces
        }
