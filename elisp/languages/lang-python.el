;;; lang-python.el --- python

(defun lang/python-hook ()
  (interactive)
  (setq python-indent-guess-indent-offset-verbose nil)
  (setq tab-width 4
	python-indent 4
	python-indent-offset 4
	python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i"))

(add-hook 'python-mode-hook 'lang/python-hook)

(provide 'lang-python)

;;; lang-python.el ends here

