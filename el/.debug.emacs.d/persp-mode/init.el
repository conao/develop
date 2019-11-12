;; ~/.debug.emacs.d/persp-mode/init.el

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
      (package-install 'leaf)))

  (prog1 "use-package"
    (unless (package-installed-p 'use-package)
      (package-refresh-contents)
      (package-install 'use-package))))



(load (locate-user-emacs-file "../essential.el"))

(use-package ivy
  :ensure t
  :custom ((ivy-mode t)
           (counsel-mode t))
  :bind (("C-s" . swiper))
  :config
  (prog1 "ivy-requirements"
    (use-package swiper :ensure t)
    (use-package counsel :ensure t))
  (use-package ivy-posframe
    :disabled t
    :ensure t
    :custom ((ivy-display-functions-alist
              '((swiper . ivy-posframe-display-at-window-bottom-left)
                (t      . ivy-posframe-display-at-window-center))))
    :config
    (let ((inhibit-message t))
      (ivy-posframe-enable))))

(use-package perspective
    :ensure t
    ;; :custom ((persp-keymap-prefix "p")
    ;;          (persp-nil-name      "default")
    ;;          (persp-auto-resume-time 3)
    ;;          (persp-mode t)
    ;;          )
    )
