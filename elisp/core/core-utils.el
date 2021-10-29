;;; core-utils.el --- Utility function

;;; Code:

(defun straight-bootstrap-p ()
  "Check is straight.el installed or not."
  (let ((bootstrap-file
         (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory)))
    (if (file-exists-p bootstrap-file)
        t
      nil)))

(provide 'core-utils)

;;; core-utils.el ends here
