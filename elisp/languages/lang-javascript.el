;;; lang-javascript.el --- Javascript mode

;;; Code:
(straight-use-package 'flymake-eslint)
(straight-use-package 'typescript-mode)

(defun lang/js-mode--setup ()
  "Javascript mode hook."
  (eglot-ensure)
  ;; (setq-local eglot-stay-out-of '(flymake))
  ;; (add-hook 'flymake-diagnostic-functions 'eglot-flymake-backend nil t)
  (local-set-key (kbd "C-c C-f") #'eglot-format-buffer))
  ;; (add-hook 'before-save-hook #'eglot-format-buffer))

(add-hook 'typescript-mode-hook #'lang/js-mode--setup)
(add-hook 'js-mode-hook #'lang/js-mode--setup)

(provide 'lang-javascript)

;;; lang-javascript.el ends here
