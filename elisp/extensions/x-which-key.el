;;; x-which-key.el --- Which key

;;; Code:

(straight-use-package 'which-key)

(which-key-mode 1)
(setq which-key-idle-delay 0.6)

(diminish 'which-key-mode)

(provide 'x-which-key)

;;; x-which-key.el ends here
