;;; lang-typscript.el --- Emacs typescript configuration

;;; Code:

(straight-use-package 'typescript-mode)

(add-hook 'typescript-mode-hook 'eglot-ensure)

(provide 'lang-typescript)

;;; lang-typescript.el ends here
