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

(leaf *initialize-emacs
  :config
  (leaf exec-path-from-shell
    :ensure t
    :when (memq window-system '(mac ns x))
    :custom ((exec-path-from-shell-check-startup-files . nil)
             (exec-path-from-shell-variables . '("PATH" "GOPATH")))
    :config
    (exec-path-from-shell-initialize))

  (prog1 "conao3 utility"
    (defmacro p (form)
      "Output expand  given FORM."
      `(progn
         (pp (macroexpand-1 ',form))
         nil))

    (defmacro po (form)
      "Output expand given FORM."
      `(progn
         (pp ,form)
         nil))

    (defmacro pl (form &optional stream)
      "Output list"
      `(progn
         (with-temp-buffer
           (insert (prin1-to-string ,form))
           (goto-char (point-min))
           (forward-char)
           (ignore-errors
             (while t (forward-sexp) (insert "\n")))
           (delete-char -1)
           (princ (buffer-substring-no-properties (point-min) (point-max))
                  (or ,stream standard-output))
           (princ "\n"))
         nil)))

  (global-unset-key (kbd "M-o")))



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
