import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import System.IO

-- utils
import XMonad.Util.Run(spawnPipe)
import XMonad.Prompt.Shell
import XMonad.Prompt

-- hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers

-- layouts
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace (onWorkspace)

-- for IM layout
import Data.Ratio ((%))
import Data.List (isInfixOf)

main = do
  xmproc <- spawnPipe "xmobar --screen 1"
  xmonad $ ewmh $ defaultConfig
    { borderWidth       = 1
    , focusFollowsMouse = False
    , modMask           = myModMask
    , keys              = myKeys
    , terminal          = "urxvt"
    , workspaces        = myWorkspaces
    , startupHook       = ewmhDesktopsStartup >> setWMName "LG3D"
    , manageHook        = myManageHook  <+> manageDocks
    , layoutHook        = myLayoutHook
    , logHook           = dynamicLogWithPP $ xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle  = xmobarColor "green" "" . shorten 50
      }
    }

-- some nice colors for the prompt windows to match the dzen status bar.
myXPConfig = defaultXPConfig
  { font                = "-*-terminus-medium-r-*-*-12-*-*-*-*-*-*-u"
  , fgColor             = "#0096d1"
  , bgColor             = "#000000"
  , bgHLight            = "#000000"
  , fgHLight            = "#FF0000"
  , position            = Top
  , historySize         = 512
  , showCompletionOnTab = True
  , historyFilter       = deleteConsecutive
  }

-------------------------------------------------------------------------------
---- Workspaces --
myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1:code1", "2:code2", "3:test", "4:console", "5:aux", "6:web", "7:mail", "8:chat", "9:misc", "0:system"]

-- logHook
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }

-- xmobar
customPP :: PP
customPP = defaultPP
  { ppHidden  = xmobarColor "#00FF00" ""
  , ppCurrent = xmobarColor "#FF0000" "" . wrap "[" "]"
  , ppUrgent  = xmobarColor "#FF0000" "" . wrap "*" "*"
  , ppLayout  = xmobarColor "#FF0000" ""
  , ppTitle   = xmobarColor "#00FF00" "" . shorten 80
  , ppSep     = "<fc=#0033FF> | </fc>"
  }

-- manageHook
myManageHook :: ManageHook
myManageHook =  composeAll . concat $
    [[isFullscreen                  --> doFullFloat
    , className =? "Xmessage"       --> doCenterFloat
    , className =? "Pidgin"         --> doShift "8:chat"
    , className =? "Empathy"        --> doShift "8:chat"
    , className =? "Skype"          --> doShift "8:chat"
    , className =? "Mail"           --> doShift "7:mail"
    , className =? "Thunderbird"    --> doShift "7:mail"
    , className =? "Xfce4-notifyd"  --> doIgnore
    , className =? "stalonetray"    --> doIgnore
    ]]

myLayoutHook = onWorkspace "8:chat" imLayout $ onWorkspace "7:mail" webL $ onWorkspace "9:misc" gimpLayout $ standardLayouts
  where
    standardLayouts = avoidStruts $ (tiled ||| reflectTiled ||| Mirror tiled ||| Grid ||| Full)

    --Layouts
    tiled         = smartBorders (ResizableTall 1 (2/100) (1/2) [])
    reflectTiled  = (reflectHoriz tiled)
    full          = noBorders Full
    webL          = avoidStruts $ full ||| tiled ||| reflectHoriz tiled
    fullL         = avoidStruts $ full

    --Im Layout
    imLayout      = avoidStruts $ smartBorders $ withIM pidginRatio pidginRoster $ withIM empathyRatio empathyRoster $ reflectHoriz $ withIM skypeRatio skypeRoster (tiled ||| reflectTiled ||| Grid)
      where
        chatLayout    = Grid
        pidginRatio   = (1%9)
        empathyRatio  = (1%8)
        skypeRatio    = (1%8)
        pidginRoster  = And (ClassName "Pidgin") (Role "buddy_list")
        empathyRoster = And (ClassName "Empathy") (Role "contact_list")
        skypeRoster   = (ClassName "Skype") `And`
                        (Role "")           `And`
                        (Not (Title "Options")) `And`
                        (Not (Title "Terms of Use"))

    -- Gimp Layout
    gimpLayout    = avoidStruts $ smartBorders $ withIM toolboxRatio gimpToolbox $ reflectHoriz $ withIM dockRatio gimpDock imageLayout
      where
        imageLayout   = (tiled ||| reflectTiled ||| Grid ||| Full)
        toolboxRatio  = (1%9)
        dockRatio     = (1%8)
        gimpToolbox   = (Role "gimp-toolbox")
        gimpDock      = (Role "gimp-dock")

-------------------------------------------------------------------------------
---- Terminal --
myTerminal :: String
myTerminal = "urxvt"

-------------------------------------------------------------------------------
-- Keys/Button bindings --
-- modmask
myModMask :: KeyMask
myModMask = mod4Mask

-- keys
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- killing programs
    [ ((modMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modMask .|. shiftMask, xK_c ), kill)

    -- opening program launcher
    , ((modMask , xK_p), shellPrompt myXPConfig)

    -- screen saver commands
    , ((modMask .|. shiftMask , xK_Escape), spawn "xscreensaver-command -lock")

    -- start a pomodoro
    , ((modMask .|. shiftMask , xK_n), spawn "touch ~/.pomodoro_session")

    -- layouts
    , ((modMask, xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask, xK_b ), sendMessage ToggleStruts)

    -- floating layer stuff
    , ((modMask, xK_t ), withFocused $ windows . W.sink)

    -- focus
    , ((modMask, xK_Tab ), windows W.focusDown)
    , ((modMask, xK_j ), windows W.focusDown)
    , ((modMask, xK_k ), windows W.focusUp)
    , ((modMask, xK_m ), windows W.focusMaster)

    -- swapping
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j ), windows W.swapDown )
    , ((modMask .|. shiftMask, xK_k ), windows W.swapUp )

    -- increase or decrease number of windows in the master area
    , ((modMask , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask , xK_period), sendMessage (IncMasterN (-1)))

    -- resizing
    , ((modMask, xK_h ), sendMessage Shrink)
    , ((modMask, xK_l ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h ), sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l ), sendMessage MirrorExpand)

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q ), io (exitWith ExitSuccess))
    , ((modMask , xK_q ), restart "xmonad" True)
    ]

    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

    ++
    -- mod-[w,e]        %! switch to twinview screen 1/2
    -- mod-shift-[w,e]  %! move window to screen 1/2
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_e, xK_w] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

