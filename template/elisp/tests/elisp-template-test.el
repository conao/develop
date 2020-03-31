;;; elisp-template-test.el --- Test definitions for elisp-template  -*- lexical-binding: t; -*-

;; Copyright (C) 2019  Naoya Yamashita

;; Author: Naoya Yamashita <conao3@gmail.com>
;; URL: https://github.com/conao3/elisp-template.el

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Test definitions for `elisp-template'.


;;; Code:

(require 'buttercup)
(require 'elisp-template)

(describe "A suite"
  (it "contains a spec with an expectation"
    (expect t :to-be t)))

;; (provide 'elisp-template-test)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; elisp-template-test.el ends here
