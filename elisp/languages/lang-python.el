;;; lang-python.el --- python

;;; Code:

(straight-use-package 'pipenv)

(defun lang/python-hook ()
  (pipenv-mode) ;; enable pipenv-mode
  (eglot-ensure) ;; activate eglot
  (setq python-indent-guess-indent-offset nil)
  (setq python-indent-guess-indent-offset-verbose nil)
  (setq tab-width 4
	    python-indent 4
	    python-indent-offset 4
	    python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i")
  (add-hook 'before-save-hook #'eglot-format-buffer))

(add-hook 'python-mode-hook #'lang/python-hook)

(provide 'lang-python)

;;; lang-python.el ends here
