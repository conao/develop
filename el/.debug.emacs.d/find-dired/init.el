(prog1 "Change user-emacs-directory"
  ;; enable debug
  (setq debug-on-error  t
        init-file-debug t)

  ;; you can run like 'emacs -q -l ~/hoge/init.el'
  (when load-file-name
    (setq user-emacs-directory
          (expand-file-name (file-name-directory load-file-name)))))

(prog1 "prepare leaf"
  (prog1 "package"
    (custom-set-variables
     '(package-archives '(("org"   . "https://orgmode.org/elpa/")
                          ("melpa" . "https://melpa.org/packages/")
                          ("gnu"   . "https://elpa.gnu.org/packages/"))))
    (package-initialize))

  (prog1 "leaf"
    (unless (package-installed-p 'leaf)
      (unless (assoc 'leaf package-archive-contents)
        (package-refresh-contents))
      (condition-case err
          (package-install 'leaf)
        (error
         (package-refresh-contents)       ; renew local melpa cache if fail
         (package-install 'leaf))))

    (leaf leaf-keywords
      :ensure t
      :config (leaf-keywords-init)))

  (prog1 "optional packages for leaf-keywords"
    ;; optional packages if you want to use :hydra, :el-get,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t
      :custom ((el-get-git-shallow-clone  . t)))))

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

  (global-unset-key (kbd "M-o"))
  (global-unset-key (kbd "M-t")))



(leaf dired
  :after dired
  :config
  (leaf find-dired
    :when (memq system-type '(darwin ms-dos windows-nt))
    :require t))

(leaf *find-dired-config
  :after find-dired
  :custom `((find-ls-option ,(cons (format "-exec %s -ld {} %s"
                                           (executable-find "ls")
                                           find-exec-terminator)
                                   "-ld"))))
