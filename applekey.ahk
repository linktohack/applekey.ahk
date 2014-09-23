;; applekey.ahk
;;
;; Apple style combo for Windows
;;
;; author  : Quang-Linh LE<linktohack@gmail.com>
;; version : 1
;; 
;; Usage : Add key sequences with specific class to the keys variable.
;;         The propitiate key sequence will be sent to the Active Window
;;         accordingly.

keys := { "#z": { Emacs:"#z", Vim:"#z", others:"^z" } 
        , "#+z": { Emacs:"#+z", Vim:"#+z", others:"^+z" }
        , "#x": { Emacs:"#x", Vim:"#x", others:"^x" }
        , "#c": { Emacs:"#c", Vim:"#c", ConsoleWindowClass: "{Enter}", others:"^c" }
        , "#v": { Emacs:"#v", Vim:"#v", others:"^v" }

        , "#a": { Emacs:"^xh", Vim:"#a", others:"^a" }
        , "#d": { Emacs:"#d", Vim:"#d", others:"^d" }

        , "#s": { Emacs:"^x^s", Vim:"#s", others:"^s" }

        , "#t": { Emacs:"^x3", Vim:"#t", others:"^t" }
        , "#w": { Emacs:"^x0", Vim:"#w", others:"^w" }
        , "#n": { Emacs:"^x2", Vim:"#n", others:"^n" } }

for k, v in keys {
  DynamicHotkey(k, "SendAppleKey", k, v)
}

SendAppleKey(k, v) {
  matched := 0
  for c, m in v {
    if WinActive("ahk_class" . c) {
      matched := 1
      ControlSend,,%m%,A
    }
  }
  if (matched == 0) {
    Send, % v.others
  }
}

DynamicHotkey(k, fun, arg*) {
  Static funs := {}, args := {}
  funs[k] := Func(fun), args[k] := arg
  Hotkey, %k%, Hotkey_Handle
  return
Hotkey_Handle:
  funs[A_ThisHotkey].(args[A_ThisHotkey]*)
  return
}