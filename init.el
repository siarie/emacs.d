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

(require 'core)
(require 'init) ;; aplications
(require 'extensions)
(require 'languages)

;; load config managed by "customize"
(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;; init.el ends here
(put 'dired-find-alternate-file 'disabled nil)
