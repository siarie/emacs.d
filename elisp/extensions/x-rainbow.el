;;; x-rainbow.el --- Rainbow delimiters config

;;; Code:

(straight-use-package 'rainbow-delimiters)

(defun x/rainbow-delimiter--setup ()
  (rainbow-delimiters-mode)
  (diminish 'rainbow-delimiters-mode))

(add-hook 'prog-mode-hook 'x/rainbow-delimiter--setup)

(provide 'x-rainbow)

;;; x-rainbow.el ends here
