;;; lang-go.el --- Golang Mode

;;; Code:

;; make sure go-mode installed
(el-get-bundle go-mode)

(defun lang/go-mode--setup ()
  "Golang mode setup."
  (local-set-key (kbd "C-c C-f") 'gofmt)
  ;; format before save
  (add-hook 'before-save-hook 'gofmt-before-save))

;; go-mode hook
(add-hook 'go-mode-hook 'lang/go-mode--setup)

(provide 'lang-go)

;;; lang-go.el ends here
