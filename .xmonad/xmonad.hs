import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit

-- utils
import XMonad.Prompt.Shell
import XMonad.Prompt

-- hooks
import XMonad.Hooks.ManageDocks

-- layouts
import XMonad.Layout.ResizableTile


main = do
  xmonad $ defaultConfig
    { borderWidth       = 1
    , focusFollowsMouse = False
    , keys              = myKeys
    , modMask           = myModMask -- Use Super instead of Alt
    , terminal          = "urxvt"
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
---- Terminal --
myTerminal :: String
myTerminal = "aterm"

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

    -- opening program launcher / search engine
    -- TODO: configure mod-P to show a launcher
    ,((modMask , xK_p), shellPrompt myXPConfig)

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
    -- mod-[w,e]        %! switch to twinview screen 1/2
    -- mod-shift-[w,e]  %! move window to screen 1/2
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_e, xK_w] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

