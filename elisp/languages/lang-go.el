;;; lang-go.el --- Golang Mode

;;; Code:

(straight-use-package 'go-mode)

(defun lang/go-mode--setup ()
  "Golang mode setup."
  ;; (eglot-ensure)
  (local-set-key (kbd "C-c C-f") 'gofmt)
  ;; format before save
  (add-hook 'before-save-hook 'gofmt-before-save))

(add-hook 'go-mode-hook 'lang/go-mode--setup)

(provide 'lang-go)

;;; lang-go.el ends here
