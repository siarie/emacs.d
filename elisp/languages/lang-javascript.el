;;; lang-javascript.el --- Javascript mode

;;; Code:

(defun lang/js-mode--setup ()
  "Javascript mode hook."
  (eglot-ensure)
  (setq js-indent-level 2))

(add-hook 'js-mode-hook 'lang/js-mode--setup)

(provide 'lang-javascript)

;;; lang-javascript.el ends here
