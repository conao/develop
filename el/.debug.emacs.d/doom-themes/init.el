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



(leaf doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

(leaf multiple-cursors
  :ensure t
  :bind (("M-u" . hydra-multiple-cursors/body))
  :config
  :hydra (hydra-multiple-cursors
          (:color pink :hint nil)
          "
									╔════════╗
    Point^^^^^^             Misc^^            Insert                            ║ Cursor ║
  ──────────────────────────────────────────────────────────────────────╨────────╜
     _k_    _K_    _M-k_    [_l_] edit lines  [_i_] numbers
     ^↑^    ^↑^     ^↑^     [_m_] mark all    [_a_] letters
    mark^^ skip^^^ un-mk^   [_s_] sort
     ^↓^    ^↓^     ^↓^
     _j_    _J_    _M-j_
  ╭──────────────────────────────────────────────────────────────────────────────╯
			   [_q_]: quit, [Click]: point
"
          ("l" mc/edit-lines :exit t)
          ("m" mc/mark-all-like-this :exit t)
          ("j" mc/mark-next-like-this)
          ("J" mc/skip-to-next-like-this)
          ("M-j" mc/unmark-next-like-this)
          ("k" mc/mark-previous-like-this)
          ("K" mc/skip-to-previous-like-this)
          ("M-k" mc/unmark-previous-like-this)
          ("s" mc/mark-all-in-region-regexp :exit t)
          ("i" mc/insert-numbers :exit t)
          ("a" mc/insert-letters :exit t)
          ("<mouse-1>" mc/add-cursor-on-click)
          ;; Help with click recognition in this hydra
          ("<down-mouse-1>" ignore)
          ("<drag-mouse-1>" ignore)
          ("q" nil)))
