;;; cider-eval-sexp-fu.el --- Briefly highlights an evaluated sexp.

;; Adapted from Sam Aaron's code found in emacs-live in order to
;; be distributable as a package by syl20bnr.

;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; Keywords: languages, clojure, cider
;; Created: 20 Mar 2015
;; Version: 1.2
;; Package-Requires: ((emacs "25.1") (eval-sexp-fu "0.5.0"))

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
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

;; Tiny feature adding support for cider eval functions.
;; See `eval-sexp-fu' help for more info on how to configure the
;; flash behavior.

;;; Code:

(require 'eval-sexp-fu)
(require 'cl-lib)

(defun cider-esf--interactive-eval-advice (f &rest args)
  "Around advice for `cider-interactive-eval'.
If bounds are provided in the arguments, use them as the region to flash,
otherwise flash the current line."
  (if eval-sexp-fu-flash-mode
      (cl-destructuring-bind (_form &optional _callback bounds _additional-params) args
        (let ((esf-bounds (if bounds (cons (car bounds) (cadr bounds))
                            ;; Some invocations pass the form to be evaled as a string, instead of the buffer bounds.
                            (cons (line-beginning-position) (line-end-position)))))
          (cl-multiple-value-bind (_bounds hi unhi eflash)
              (eval-sexp-fu-flash esf-bounds)
            (esf-flash-doit (esf-konstantly (apply f args)) hi unhi eflash))))
    (apply f args)))

(defun cider-esf--initialize-cider ()
  "Initialize the CIDER integration for eval-sexp-fu."
  (advice-add 'cider-interactive-eval :around #'cider-esf--interactive-eval-advice))

(eval-after-load 'cider
  '(cider-esf--initialize-cider))

(provide 'cider-eval-sexp-fu)

;;; cider-eval-sexp-fu.el ends here
