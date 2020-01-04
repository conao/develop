;;; essentials.el --- essentials                                -*- lexical-binding: t; -*-

;; Copyright (C) 2019 Naoya Yamashita

;; Author: Naoya Yamashita <conao3@gmail.com>
;; Keywords: lisp

;; Copyright (C) 2019  Naoya Yamashita

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU Affero General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;; See the GNU Affero General Public License for more details.

;; You should have received a copy of the GNU Affero General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(leaf *initialize-emacs
  :custom (((debug-on-error  . t)
            (init-file-debug . t))))

(leaf autorevert
  :doc "revert buffers when files on disk change"
  :custom ((auto-revert-interval . 1)
           (global-auto-revert-mode . t)))

(leaf ppp :ensure t)

(leaf real-auto-save
  :ensure t
  :custom ((real-auto-save-interval . 0.3))
  :commands (real-auto-save-activate-advice)
  :hook ((find-file-hook . real-auto-save-mode))
  :config (real-auto-save-activate-advice))

(leaf company
  :ensure t
  :leaf-defer nil
  :bind ((company-active-map
          ("M-n" . nil)
          ("M-p" . nil)
          ("C-s" . company-filter-candidates)
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)
          ("<tab>" . company-complete-selection))
         (company-search-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)))
  :custom ((company-tooltip-limit         . 12)
           (company-idle-delay            . 0)
           (company-minimum-prefix-length . 1)
           (company-transformers          . '(company-sort-by-occurrence))
           (global-company-mode           . t)))

(provide 'essentials)
;;; essentials.el ends here
