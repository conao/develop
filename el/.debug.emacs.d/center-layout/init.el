;;; init.el --- Sample init.el  -*- lexical-binding: t; -*-

;;; Commentary:

;; ~/.debug.emacs.d/center-layout/init.el

;;; Code:

;; you can run like 'emacs -q -l ~/.debug.emacs.d/{{pkg}}/init.el'
(when load-file-name
  (setq user-emacs-directory
        (expand-file-name (file-name-directory load-file-name))))

(eval-when-compile
  (setq user-emacs-directory
        (expand-file-name (file-name-directory default-directory))))

(eval-and-compile
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
  (leaf leaf-keywords
    :ensure t
    :init
    (leaf el-get :ensure t
      :custom ((el-get-git-shallow-clone . t)))
    :config
    (leaf-keywords-init)))



(load (locate-user-emacs-file "../essentials.el"))

(leaf center-layout
  :require t
  :el-get (center-layout :url "https://gitlab.com/lae/emacs-center-layout.git")
  :custom ((center-layout-mode . t)))

;;; init.el ends here
