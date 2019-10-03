;; leaf-diminish init.el

(prog1 "Change user-emacs-directory"
  ;; enable debug
  (setq debug-on-error  t
        init-file-debug t)

  ;; you can run like 'emacs -q -l ~/hoge/init.el'
  (when load-file-name
    (setq user-emacs-directory
          (expand-file-name (file-name-directory load-file-name)))))

(defvar bootstrap-version)
(let ((bootstrap-file (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq load-prefer-newer t)

(setq straight-check-for-modifications '(check-on-save-find-when-checking))

(require 'straight-x)

(straight-use-package 'leaf)
(straight-use-package 'leaf-keywords)
(straight-use-package 'diminish)

(leaf leaf
  :config
  (leaf leaf-keywords
    :config
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



(leaf projectile
  :straight t
  :diminish projectile-mode
  :custom `((projectile-file-exists-remote-cache-expire . ,(* 10 60))
            (projectile-indexing-method . 'alien)
            (projectile-enable-caching . t)
            (projectile-completion-system . 'ivy)
            (projectile-mode . t)))
