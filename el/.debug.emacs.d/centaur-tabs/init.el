(eval-when-compile
  (prog1 "package"
    (defvar package-archives)
    (autoload #'package-installed-p "package")
    (setq user-emacs-directory
          (expand-file-name (file-name-directory default-directory)))
    (setq package-archives '(("org"   . "https://orgmode.org/elpa/")
                             ("melpa" . "https://melpa.org/packages/")
                             ("gnu"   . "https://elpa.gnu.org/packages/")))
    (package-initialize)
    (unless (package-installed-p 'leaf)
      (package-refresh-contents) (package-install 'leaf)))

  (leaf leaf-keywords
    :ensure t
    :config
    (leaf-keywords-init)
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)))

(leaf *basic-configure
  ;; enable debug
  :custom `((debug-on-error  . t)
            (init-file-debug . t)
            (user-emacs-directory
             . ,(if load-file-name
                    (expand-file-name (file-name-directory load-file-name))
                  user-emacs-directory))))

(leaf *leaf
  :config
  (leaf package
    :custom ((package-archives . '(("org"   . "https://orgmode.org/elpa/")
                                   ("melpa" . "https://melpa.org/packages/")
                                   ("gnu"   . "https://elpa.gnu.org/packages/"))))
    :config (package-initialize))

  (leaf hydra :ensure t :require t)
  (leaf el-get :ensure t
    :custom ((el-get-git-shallow-clone  . t))))



(leaf centaur-tabs
  :ensure t
  :custom ((centaur-tabs-mode . t))
  :bind (("C-<prior>" . centaur-tabs-backward)
         ("C-<next>"   . centaur-tabs-forward)))
