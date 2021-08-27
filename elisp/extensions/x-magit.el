;;; x-magit.el --- magit configurations

;;; Code:

(el-get-bundle magit)

(with-eval-after-load 'magit
  (setq transient-default-level 5
	    magit-completing-read-function 'ivy-completing-read))


(provide 'x-magit)

;;; x-magit.el ends here
