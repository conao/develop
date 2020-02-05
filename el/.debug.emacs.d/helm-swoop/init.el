;; ~/.debug.emacs.d/helm-swoop/init.el

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
  :load-path `,(locate-user-emacs-file "site-lisp/helm")
  ;; :ensure t
  :require helm-config
  :leaf-defer nil
  :init
  (leaf async :require t :load-path* "site-lisp/async")
  (leaf popup :require t :load-path* "site-lisp/popup")
  :bind (("M-x"     . helm-M-x)
         ("C-x r b" . helm-filtered-bookmarks)
         ("C-x C-f" . helm-find-files))
  :custom ((helm-mode . t))
  :config
  (leaf helm-swoop
    :load-path `,(locate-user-emacs-file "site-lisp/helm-swoop")
    ;; :ensure t
    :require t
    :bind (("M-i"     . helm-swoop)
           ("M-C-i"   . helm-swoop-back-to-last-point)
           ("C-c M-i" . helm-multi-swoop)
           ("C-x M-i" . helm-multi-swoop-all)
           (:isearch-mode-map ("M-i" . helm-swoop-from-isearch))
           (:helm-swoop-map   ("M-i" . helm-multi-swoop-all-from-helm-swoop)))
    :config
    (setq helm-swoop-pre-input-function
          (lambda ()
            (let (($pre-input (thing-at-point 'symbol)))
              (if (eq (length $pre-input) 0)
                  helm-swoop-pattern ;; this variable keeps the last used words
                $pre-input))))))
