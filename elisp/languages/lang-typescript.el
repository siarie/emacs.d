;;; lang-typscript.el --- Emacs typescript configuration

;;; Code:

(straight-use-package 'typescript-mode)

(defun lang/ts-mode--setup ()
  (eglot-ensure)
  (add-hook 'before-save-hook #'eglot-format-buffer))

(add-hook 'typescript-mode-hook #'lang/ts-mode--setup)

(provide 'lang-typescript)

;;; lang-typescript.el ends here
