;;; lang-javascript.el --- Javascript mode

;;; Code:

(defun lang/js-mode--setup ()
  "Javascript mode hook."
  (setq tab-width 2))

(add-hook 'js-mode-hook 'lang/js-mode--setup)

(provide 'lang-javascript)

;;; lang-javascript.el ends here
