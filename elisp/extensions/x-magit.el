;;; x-magit.el --- magit configurations

;;; Code:

(straight-use-package 'magit)

(with-eval-after-load 'magit
  (setq transient-default-level 5
	    magit-completing-read-function 'ivy-completing-read))


(provide 'x-magit)

;;; x-magit.el ends here
