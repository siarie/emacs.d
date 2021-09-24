;;; lang-python.el --- python

(straight-use-package 'python-black)

(defun lang/python-hook ()
  (setq python-indent-guess-indent-offset-verbose nil)
  (setq tab-width 4
	    python-indent 4
	    python-indent-offset 4
	    python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i")
  (python-black-on-save-mode))

(add-hook 'python-mode-hook 'lang/python-hook)

(provide 'lang-python)

;;; lang-python.el ends here
