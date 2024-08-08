; OM Preferences - Saved 2022/04/27 12:34:11 - OpenMusic 7.0
(in-package :om)(setf *saved-pref* (quote ((:general (list :handle-errors t :user-name "Guarigocha" :eval-process :on :tooltips t :reactive t :listener-input nil :listener-on-top :no :out-files-dir (om-make-pathname :directory (quote (:absolute "USERS" "NEIMOG" "ONEDRIVE_USP.BR" "DOCUMENTS" "OPENMUSIC" "WORKSPACE-NEW" "out-files")) :device nil :host "C" :name nil :type nil) :tmp-files-dir (om-make-pathname :directory (quote (:absolute "USERS" "NEIMOG" "ONEDRIVE_USP.BR" "DOCUMENTS" "OPENMUSIC" "WORKSPACE-NEW" "out-files")) :device nil :host "C" :name nil :type nil) :in-files-dir (om-make-pathname :directory (quote (:absolute "USERS" "NEIMOG" "ONEDRIVE_USP.BR" "DOCUMENTS" "OPENMUSIC" "WORKSPACE-NEW" "in-files")) :device nil :host "C" :name nil :type nil)) 7.0) (:appearance (list (quote :comment-font) (om-make-font "Verdana" 12 :family "Verdana" :style (quote (:plain)) :mode (quote nil)) (quote :comment-color) (om-make-color 0 0 0) (quote :ws-color) (om-make-color 0.85 0.87 0.87) (quote :box-fact) 1 (quote :gen-bg-color) (om-make-color 1 1 1) (quote :patch-bg-color) (om-make-color 1 1 1) (quote :score-bg-color) (om-make-color 1 1 1) (quote :text-bg-color) (om-make-color 1 1 1) (quote :bpf-bg-color) (om-make-color 1 1 1) (quote :sound-bg-color) (om-make-color 1 1 1) (quote :boxname-font) (om-make-font "Verdana" 11 :family "Verdana" :style (quote (:plain)) :mode (quote nil)) (quote :folder-pres) 0 (quote :patch-win-buttons) (quote t) (quote :curved-connections) nil (quote :mv-font-size) 20 (quote :maq-color) (om-make-color 0.85 0.85 0.83) (quote :patchtemp-color) (om-make-color 0.5 0.5 0.6) (quote :maqtemp-color) (om-make-color 0.6 0.5 0.5) (quote :objtemp-color) (om-make-color 0.5 0.6 0.5) (quote :temp-minipict-bg) nil (quote :temp-minipict-mode) (quote :score) (quote :temp-show-icons) (quote t)) 7.0) (:userlibs (list :auto-load-libs (list (list "OM-Spat" (om-make-pathname :directory (quote (:absolute "USERS" "CHARL" "ONEDRIVE_USP.BR" "DOCUMENTS" "OPENMUSIC" "OM-LIBRARIES" "OM-Spat")) :device :unspecific :host "C" :name "OM-Spat" :type "lisp")) (list "OM-Sieves" (om-make-pathname :directory (quote (:absolute "USERS" "CHARL" "ONEDRIVE_USP.BR" "DOCUMENTS" "OPENMUSIC" "OM-LIBRARIES" "OM-Sieves")) :device :unspecific :host "C" :name "OM-Sieves" :type "lisp"))) :user-lib-dirs (list (om-make-pathname :directory (quote (:absolute "USERS" "NEIMOG" "ONEDRIVE_USP.BR" "DOCUMENTS" "OPENMUSIC" "OM-LIBRARIES")) :device nil :host "C" :name nil :type nil) (om-make-pathname :directory (quote (:absolute "USERS" "CHARL" "ONEDRIVE_USP.BR" "DOCUMENTS" "OPENMUSIC" "OM-LIBRARIES")) :device nil :host "C" :name nil :type nil))) 7.0) (:externals (list :multiplayer-path nil :multiplayer-options (list 7071 7072 "127.0.0.1") :spat-path (om-make-pathname :directory (quote (:absolute "Users" "charl" "OneDrive_usp.br" "Documents" "Max 8" "Packages" "spat5-x64" "media" "tools")) :device nil :host "C" :name "spat-sdif-renderer" :type "exe") :spat-options (list 2 "angular" nil (om-make-pathname :directory (quote (:absolute "USERS" "CHARL" "ONEDRIVE_USP.BR" "DOCUMENTS" "OPENMUSIC" "OM-LIBRARIES" "OM-Spat" "resources" "hrtf")) :device nil :host nil :name "IRC_9002_itd_24order_biquads_44100" :type "hrtf") 8 1 32)) 7.0) (:score (list (quote :approx) 8 (quote :fontsize) 24 (quote :staff) (quote g) (quote :sys-color) (om-make-color 0 0 0) (quote :select-color) (om-make-color 0.5 0.5 0.5) (quote :hide-stems) nil (quote :stem-size-fact) 1 (quote :chord-stem-dir) "neutral" (quote :dyn-list) (list 20 40 55 60 85 100 115 127) (quote :tonal-options) (list (quote t) (quote t) nil nil nil nil) (quote :diapason) 440.0) 7.0) (:conversion (list (quote :delta-chords) 100 (quote :quantify) (list 60 (list 4 4) 8 0 nil 0.5)) 7.0) (:midi (list (quote :midi-out) 0 (quote :midi-in) 0 (quote :port-modulo-channel) nil (quote :midi-system) (quote :portmidi) (quote :score-player) (quote :osc-scoreplayer) (quote :force-player) (quote t) (quote :midi-file-system) (quote :cl-midi) (quote :midi-format) 1 (quote :channel-shift) (list 4 8) (quote :channel-shift-approx) 8 (quote :auto-microtone-bend) nil (quote :midi-setup) (list (list (list 0 nil)) (list (list 0 (list "Microsoft GS Wavetable Synth")))) (quote :midi-presets) (list (list "-----" nil))) 7.0) (:audio (list :audio-format (quote :wav) :sys-console t :audio-sr 44100 :audio-res 32 :auto-rename nil :delete-tmp t :normalize t :normalize-level 0.0 :normalizer :om :audio-device "Driver de som prim�rio" :audio-n-channels 2) 7.0))))