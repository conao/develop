(prog1 "Change user-emacs-directory"
  ;; enable debug
  (setq debug-on-error  t
        init-file-debug t)

  ;; you can run like 'emacs -q -l ~/hoge/init.el'
  (when load-file-name
    (setq user-emacs-directory
          (expand-file-name (file-name-directory load-file-name)))))

(prog1 "Load use-package.el"
  (setq package-archives '(("org"   . "https://orgmode.org/elpa/")
			   ("melpa" . "https://melpa.org/packages/")
                           ("gnu"   . "https://elpa.gnu.org/packages/")))
  (package-initialize)

  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (require 'use-package))

(use-package use-package
  :custom ((use-package-expand-minimally t)
           (use-package-hook-name-suffix "")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
    :ensure t
    :custom ((ivy-display-functions-alist
              '((swiper . ivy-posframe-display-at-window-bottom-left)
                (t      . ivy-posframe-display-at-window-center))))
    :config
    (let ((inhibit-message t))
      (ivy-posframe-enable))))

(use-package persp-mode
    :ensure t
    :custom ((persp-keymap-prefix "p")
             (persp-nil-name      "default")
	     (persp-auto-resume-time 3)
             (persp-mode t)
	     )
    :hook ((emacs-startup-hook . toggle-frame-maximized))
    :config
    (prog1 "https://github.com/Bad-ptr/persp-mode.el#ivy"
      (with-eval-after-load "ivy"
        (add-hook 'ivy-ignore-buffers
                  #'(lambda (b)
                      (when persp-mode
                        (let ((persp (get-current-persp)))
                          (if persp
                              (not (persp-contain-buffer-p b persp))
                            nil)))))

        (setq ivy-sort-functions-alist
              (append ivy-sort-functions-alist
                      '((persp-kill-buffer   . nil)
                        (persp-remove-buffer . nil)
                        (persp-add-buffer    . nil)
                        (persp-switch        . nil)
                        (persp-window-switch . nil)
                        (persp-frame-switch  . nil)))))))
