;;; flycheck-bidi --- Check for bidi unicode control characters in prog-mode

;;; Commentary:

;;; Code:
(require 'flycheck)

(defgroup flycheck-bidi nil
  "Display Flycheck errors for bidi control characters."
  :prefix "flycheck-bidi-"
  :group 'flycheck
  :link '(url-link :tag "Github" "https://github.com/alexmurray/flycheck-bidi"))

(defcustom flycheck-bidi-warn-chars bidi-directional-controls-chars
  "The character set to warn on."
  :group 'flycheck-bidi
  :type 'string)

(defun flycheck-bidi--scan-buffer ()
  "Scan current buffer for bidi control characters."
  (save-excursion
    (let ((posns))
      (goto-char (point-min))
      (while (re-search-forward (concat "[" flycheck-bidi-warn-chars "]") nil t)
        (push (cons (line-number-at-pos) (current-column)) posns))
      (nreverse posns))))

(defun flycheck-bidi--pos-to-fc-error (pos)
  (flycheck-error-new-at
   (car pos) (cdr pos)
   'warning
   "Bidirectional unicode text may be interpreted or compiled differently than how it appears"))

(defun flycheck-bidi-checker-start (checker callback)
  (condition-case err
      (let ((fc-errors (mapcar #'flycheck-bidi--pos-to-fc-error
                               (flycheck-bidi--scan-buffer))))
        (funcall callback 'finished fc-errors))
    (error (funcall callback 'errored (error-message-string err)))))


(flycheck-define-generic-checker 'bidi
  "Check for bidi control chars in code."
  :modes '(c-mode)
  :start #'flycheck-bidi-checker-start)

(provide 'flycheck-bidi)
;;; flycheck-bidi.el ends here
