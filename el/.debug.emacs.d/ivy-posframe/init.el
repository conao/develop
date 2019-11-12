;; ~/.debug.emacs.d/ivy-posframe/init.el

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



(load (locate-user-emacs-file "../essential.el"))

(leaf ivy
  :ensure t
  :leaf-defer nil
  :custom ((ivy-mode     . t)
           (counsel-mode . t))
  :bind (("C-s" . swiper))
  :config
  (leaf "&ivy-requirements"
    :config
    (leaf swiper :ensure t)
    (leaf counsel :ensure t))
  (leaf ivy-posframe
    :require t
    :load-path "~/dev/forks/ivy-posframe/"
    :init (leaf posframe :ensure t)
    :custom ((ivy-posframe-display-functions-alist
              . '((swiper . nil)
                  (t      . ivy-posframe-display-at-window-center))))
    :config
    (ivy-posframe-mode t)))
