;; undo-tree init.el

(prog1 "Change user-emacs-directory"
  ;; enable debug
  (setq debug-on-error  t
        init-file-debug t)

  ;; you can run like 'emacs -q -l ~/hoge/init.el'
  (when load-file-name
    (setq user-emacs-directory
          (expand-file-name (file-name-directory load-file-name)))))

(prog1 "leaf"
  (prog1 "install leaf"
    (custom-set-variables
     '(package-archives '(("org"   . "https://orgmode.org/elpa/")
                          ("melpa" . "https://melpa.org/packages/")
                          ("gnu"   . "https://elpa.gnu.org/packages/")
                          )))
    (package-initialize)
    (unless (package-installed-p 'leaf)
      (package-refresh-contents)
      (package-install 'leaf)))

  (leaf leaf-keywords
    :ensure t
    :config
    ;; optional packages if you want to use :hydra, :el-get,,,
    (leaf el-get :ensure t
      :custom ((el-get-git-shallow-clone . t)))

    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

(leaf cus-start
    :doc "define customization properties of builtins"
    :url "http://handlename.hatenablog.jp/entry/2011/12/11/214923" ; align sumple
    :bind (("M-ESC ESC" . keyboard-quit))
    ;; :hook ((before-save-hook . delete-trailing-whitespace))
    :custom `((create-lockfiles                . nil)
              (use-dialog-box                  . nil)
              (use-file-dialog                 . nil)
              (frame-resize-pixelwise          . t)
              (enable-recursive-minibuffers    . t)
              (history-length                  . 1000)
              (history-delete-duplicates       . t)
              (inhibit-compacting-font-caches  . t)
              (scroll-preserve-screen-position . t)

              (truncate-lines   . t)
              (menu-bar-mode    . t)
              (tool-bar-mode    . nil)
              (indent-tabs-mode . nil))
    :config
    (keyboard-translate ?\C-h ?\C-?)
    (mapc (lambda (func) (put func 'disabled nil))
          (cdr '(:dummy
                 upcase-region downcase-region
                 narrow-to-region narrow-to-page narrow-to-defun
                 list-timers))))

(leaf autorevert
      :doc "revert buffers when files on disk change"
      :custom ((auto-revert-interval . 1)
               (global-auto-revert-mode . t)))





;; (leaf undo-tree
;;   :ensure t
;;   :config (global-undo-tree-mode t)
;;   :bind (("M-/" . undo-tree-redo)))

(leaf undo-tree
  :ensure t
  :leaf-defer nil
  :bind (("M-/" . undo-tree-redo))
  :custom ((global-undo-tree-mode . t)))

