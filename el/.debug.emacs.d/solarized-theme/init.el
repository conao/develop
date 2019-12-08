;; ~/.debug.emacs.d/solarized-theme/init.el

;; you can run like 'emacs -q -l ~/.debug.emacs.d/{{pkg}}/init.el'
(when load-file-name
  (setq user-emacs-directory
        (expand-file-name (file-name-directory load-file-name))))

(prog1 "leaf"
  (prog1 "install leaf"
    (custom-set-variables
     '(package-archives '(("org"   . "https://orgmode.org/elpa/")
                          ("melpa" . "https://melpa.org/packages/")
                          ("gnu"   . "https://elpa.gnu.org/packages/"))))
    (package-initialize)
    (unless (package-installed-p 'leaf)
      (package-refresh-contents)
      (package-install 'leaf))))



(load (locate-user-emacs-file "../essentials.el"))

(leaf solarized-theme
    :ensure t
    :when (version<= "24.1" emacs-version)
    :custom ((solarized-distinct-fringe-background . t))
    :defun (solarized-create-theme-file-with-palette solarized-color-blend)
    :require t
    :preface
    (defun c/reload-theme ()
      (interactive)
      (let ((theme-name (save-excursion
                          (goto-char (point-min))
                          (re-search-forward "deftheme \\([^ ]*\\)")
                          (substring-no-properties (match-string 1)))))
        (eval-buffer)
        (load-theme (intern theme-name) t)))
    :config
    
    (solarized-create-theme-file-with-palette 'dark 'solarized-zenburn-dark
      '("#3F3F3F" "#FFFFFF"           ; base03 (02 01 00 0 1 2) base3
        "#b58900" "#cb4b16"           ; yellow orange
        "#dc322f" "#d33682"           ; red    magenta
        "#6c71c4" "#268bd2"           ; violet blue
        "#2aa198" "#F0DFAF"           ; cyan   green
        )
      '((custom-theme-set-faces
         theme-name
         ;; `(default ((,class (:foreground ,base2 :background ,base03))))
         ;; `(vertical-border ((,class (:foreground ,base03))))
         ;; `(mode-line ((,class (:foreground ,base2 :background ,base02))))
         ;; `(mode-line-inactive ((,class (:foreground ,base0 :background ,base03))))
         ;; `(font-lock-builtin-face ((,class (:foreground ,magenta))))
         ))
      t)
    ;; (solarized-create-theme-file-with-palette 'dark 'solarized-zenburn-dark
    ;;     '("#3F3F3F" "#FFFFFD"           ; base03 (02 01 00 0 1 2) base3
    ;;       "#F0DFAF" "#DFAF8F"           ; yellow orange
    ;;       "#CC9393" "#DC8CC3"           ; red    magenta
    ;;       "#6C3333" "#8CD0D3"           ; violet blue
    ;;       "#93E0E3" "#7F9F7F"           ; cyan   green
    ;;       ))
    (load-theme 'solarized-zenburn-dark t))
