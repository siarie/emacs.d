;;; init.el --- emacs init

;;; Code:

(let ((minver "26.0"))
  (when (version< emacs-version minver)
    (error "this config requires emacs v%s or higher." minver)))

(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

;; quiet startup
(setq inhibit-startup-message t
      initial-scratch-message nil)
(add-hook 'emacs-startup-hook (lambda () (message "")))

;; load core configuretion
;; Note!. Don't put any straight.el stuff on the core config
(require 'core)

;; straight.el bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(require 'init) ;; aplications
(require 'extensions)
(require 'languages)

;; load config managed by "customize"
(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;; init.el ends here
