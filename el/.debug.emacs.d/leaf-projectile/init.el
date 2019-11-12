;; ~/.debug.emacs.d/leaf-projectile/init.el

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



(leaf projectile
  :straight t
  :diminish projectile-mode
  :custom `((projectile-file-exists-remote-cache-expire . ,(* 10 60))
            (projectile-indexing-method . 'alien)
            (projectile-enable-caching . t)
            (projectile-completion-system . 'ivy)
            (projectile-mode . t)))
