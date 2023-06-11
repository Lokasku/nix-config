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

myLayoutHook = let myGaps = 7
               in mkToggle (single FULL)
                    $ avoidStruts
                    $ spacingRaw False (Border 0 myGaps 0 myGaps) True (Border myGaps 0 myGaps 0) True
                    $ ResizableTall 1 (2/100) (1/2) []

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

myLogHook = wallpaperSetter defWallpaperConf {
                                wallpapers = defWPNamesJpg myWorkspaces
                                    <> WallpaperList [("1", WallpaperFix "~/.wallpapers/nixos-wallpaper-light.jpg")]
                            }

main = do
    -- h <- spawnPipe "xmobar /etc/nixos/xmonad/xmobar.hs"
    xmonad $ ewmhFullscreen $ ewmh $ docks $ def
        { borderWidth        = 2
        , terminal           = "alacritty"
        , normalBorderColor  = "#b3b3b3"
        , focusedBorderColor = "#ae77be"
        , layoutHook         = myLayoutHook
        , logHook            = myLogHook
        , workspaces         = myWorkspaces
        }
