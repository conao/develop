;; ~/.debug.emacs.d/ivy-posframe-with-avy/init.el

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

(leaf avy :ensure t)

(leaf ivy
  :custom ((ivy-mode     . t)
           (counsel-mode . t))
  :config
  (leaf swiper
    :ensure t
    :bind (("C-s" . swiper)
           ("C-'" . swiper-avy)))

  (leaf ivy-posframe
    :ensure t
    :bind ((ivy-posframe-mode-map
            ([remap swiper-avy] . nil)))
    :custom ((ivy-posframe-mode . t)
             (ivy-posframe-display-functions-alist
              . '((swiper-avy . nil)
                  (swiper . nil)
                  (t . ivy-posframe-display-at-frame-center)))
             (ivy-posframe-parameters
              . '((left-fringe . 8)
                  (right-fringe . 8))))))
