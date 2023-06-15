import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe, hPutStrLn)

import XMonad.Hooks.ManageDocks (avoidStruts, docks)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.WallpaperSetter
import XMonad.Hooks.DynamicLog

import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing (Border (..), spacingRaw)
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.ResizableTile

import qualified XMonad.StackSet as W

import XMonad.Actions.Submap (submap)
import XMonad.Actions.FloatKeys (keysResizeWindow)
import XMonad.Actions.CycleWS

import Data.Bool (bool)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import System.Environment

myLayoutHook = let myGaps = 5
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
    [ ("M-" ++ k, windows $ W.greedyView i) | (i, k) <- zip workspaceNames mainKeys ]
    where
      (mainKeys, workspaceNames) = unzip myWorkspaces

myLogHook = wallpaperSetter defWallpaperConf {
                                wallpapers = defWPNamesJpg (map snd myWorkspaces)
                                    <> WallpaperList [("dev", WallpaperFix "~/.wallpapers/nixos-wallpaper-dark.jpg")]
                            }
myTerminal = "alacritty"

myKeys :: XConfig a -> [(String, X ())]
myKeys c =
    [
    -- M-
      ("M-<Space>", spawn (terminal c))
    , ("M-p", spawn "dmenu_run -fn 'Pragmata Pro:size=10' -nb '#232323' -nf '#C5C5C5' -sb '#2F2F2F' -sf '#FFFFFF' -p 'find:'")
    , ("M-k", kill)
    , ("M-b", moveUp)
    , ("M-n", moveDown)

    -- S-
    , ("S-<U>", spawn "redshift -P -O 3500")
    , ("S-<D>", spawn "redshift -P -O 6500")

    -- M-S-
    , ("M-S-<R>", nextWS)
    , ("M-S-<L>", prevWS)
    
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

      moveUp   = windows $ W.focusUp
      moveDown = windows $ W.focusDown

isFloating :: Window -> X Bool
isFloating win = gets (Map.member win . W.floating . windowset)

myWallpaper :: String -> X ()
myWallpaper w = do
    homeDir <- io $ getEnv "HOME"
    spawn $ "feh --bg-fill " ++ homeDir ++ "/" ++ w

main = do
    h <- spawnPipe "xmobar ~/.config/nixpkgs/config/xmonad/xmobar.hs"
    xmonad $ ewmhFullscreen $ ewmh $ docks $ def
        { borderWidth        = 2
        , terminal           = myTerminal
        , normalBorderColor  = "#585858"
        , focusedBorderColor = "#ae77be"
        , layoutHook         = myLayoutHook
        , logHook            = dynamicLogWithPP $ def { ppOutput = hPutStrLn h }
        , startupHook        = myWallpaper ".wallpapers/flake-wallpaper.jpg"
        , keys               = \ c -> mkKeymap c (myKeys c)
        , workspaces         = snd <$> myWorkspaces
        }
