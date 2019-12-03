;;; init.el --- leaf bytecompile sample   -*- lexical-binding: t; -*-

;;; Commentary:

;; leaf bytecompile sample

;;; Code:

;; ~/.debug.emacs.d/leaf/init.el

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
      (package-install 'leaf)))

  (leaf leaf-keywords
    :ensure t
    :config
    ;; optional packages if you want to use :hydra, :el-get,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t
      :custom ((el-get-git-shallow-clone . t)))

    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))



(load (locate-user-emacs-file "../essentials.el"))

(leaf magit
  :when (version<= "25.1" emacs-version)
  :ensure t
  :preface
  (defun c/git-commit-a ()
    "Commit after add anything."
    (interactive)
    (shell-command "git add .")
    (magit-commit-create))
  :bind (("M-=" . hydra-magit/body))
  :hydra (hydra-magit
          (:hint nil :exit t)
          "
^^         hydra-magit
^^------------------------------
 _s_   magit-status
 _C_   magit-clone
 _c_   magit-commit
 _d_   magit-diff-working-tree
 _M-=_ magit-commit-create"
          ("s" magit-status)
          ("C" magit-clone)
          ("c" magit-commit)
          ("d" magit-diff-working-tree)
          ("M-=" c/git-commit-a)))

;;; init.el ends here
