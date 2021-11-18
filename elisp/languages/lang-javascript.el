;;; lang-javascript.el --- Javascript mode

;;; Code:

(defun lang/js-mode--setup ()
  "Javascript mode hook."
  (eglot-ensure)
  (setq js-indent-level 4)
  (local-set-key (kbd "C-c C-f") #'eglot-format-buffer))
  ;; (add-hook 'before-save-hook #'eglot-format-buffer))

(add-hook 'js-mode-hook #'lang/js-mode--setup)

(provide 'lang-javascript)

;;; lang-javascript.el ends here
