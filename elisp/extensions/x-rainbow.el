;;; x-rainbow.el --- Rainbow delimiters config

;;; Code:

(el-get-bundle rainbow-delimiters)

(add-hook 'prog-mode-hook 'x/rainbow-delimiter--setup)

(defun x/rainbow-delimiter--setup ()
  (rainbow-delimiters-mode)
  (diminish 'rainbow-delimiters-mode))

(provide 'x-rainbow)

;;; x-rainbow.el ends here
