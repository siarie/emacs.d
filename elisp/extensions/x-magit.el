;;; x-magit.el --- magit configurations

;;; Code:

(straight-use-package 'magit)

(with-eval-after-load 'magit
  (setq transient-default-level 5
	    magit-completing-read-function 'ivy-completing-read))

;; Use git-gui--askpass on windows
(when (eq system-type 'windows-nt)
  (setenv "GIT_ASKPASS" "git-gui--askpass")
  (setenv "SSH_ASKPASS" "git-gui--askpass"))

(provide 'x-magit)

;;; x-magit.el ends here
