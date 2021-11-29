;;; lang-javascript.el --- Javascript mode

;;; Code:
(straight-use-package 'flymake-eslint)
(straight-use-package 'typescript-mode)
(straight-use-package 'js2-mode)
(straight-use-package 'json-mode)

(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))

(defun lang/js-mode--setup ()
  "Javascript mode hook."
  (js2-minor-mode)
  (eglot-ensure)
  ;; (setq-local eglot-stay-out-of '(flymake))
  ;; (add-hook 'flymake-diagnostic-functions 'eglot-flymake-backend nil t)
  (local-set-key (kbd "C-c C-f") #'eglot-format-buffer))
  ;; (add-hook 'before-save-hook #'eglot-format-buffer))

(add-hook 'typescript-mode-hook #'lang/js-mode--setup)
(add-hook 'js-mode-hook #'lang/js-mode--setup)
(add-hook 'json-mode-hook (lambda ()
                            (js2-minor-mode -1)))

(provide 'lang-javascript)

;;; lang-javascript.el ends here
