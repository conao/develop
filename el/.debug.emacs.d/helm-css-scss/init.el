;; ~/.debug.emacs.d/helm-css-scss/init.el

;; you can run like 'emacs -q -l ~/.debug.emacs.d/{{pkg}}/init.el'
(when load-file-name
  (setq user-emacs-directory
        (expand-file-name (file-name-directory load-file-name))))

(prog1 "prepare leaf"
  (prog1 "package"
    (custom-set-variables
     '(package-archives '(("org"   . "https://orgmode.org/elpa/")
                          ("melpa" . "https://melpa.org/packages/")
                          ("gnu"   . "https://elpa.gnu.org/packages/"))))
    (package-initialize))

  (prog1 "leaf"
    (unless (package-installed-p 'leaf)
      (package-refresh-contents)
      (package-install 'leaf))))



(load (locate-user-emacs-file "../essentials.el"))

(leaf helm
  :ensure t
  :require helm-config
  :leaf-defer nil
  :bind (("M-x"     . helm-M-x)
         ("C-x r b" . helm-filtered-bookmarks)
         ("C-x C-f" . helm-find-files))
  :custom ((helm-mode . t))
  :config
  (leaf helm-css-scss
    :load-path `,(locate-user-emacs-file "site-lisp/helm-css-scss")
    :require t
    ;; :ensure t
    :config
    ;; Allow comment inserting depth at each end of a brace
    (setq helm-css-scss-insert-close-comment-depth 2)
    ;; If this value is t, split window appears inside the current window
    (setq helm-css-scss-split-with-multiple-windows nil)
    ;; Split direction. 'split-window-vertically or 'split-window-horizontally
    (setq helm-css-scss-split-direction 'split-window-vertically)

    ;; Set local keybind map for css-mode / scss-mode / less-css-mode
    (dolist ($hook '(css-mode-hook scss-mode-hook less-css-mode-hook))
      (add-hook
       $hook (lambda ()
               (local-set-key (kbd "s-i") 'helm-css-scss)
               (local-set-key (kbd "s-I") 'helm-css-scss-back-to-last-point))))

    (define-key isearch-mode-map (kbd "s-i") 'helm-css-scss-from-isearch)
    (define-key helm-css-scss-map (kbd "s-i") 'helm-css-scss-multi-from-helm-css-scss)))
