;;; init.el --- emacs init

(let ((minver "26.0"))
  (when (version< emacs-version minver)
    (error "this config requires emacs v%s or higher." minver)))

;; disable backup
(setq make-backup-files nil)

;; ask y or n instead yes or no
(defalias 'yes-or-no-p 'y-or-n-p)

;; quiet startup
(setq inhibit-startup-message t
      initial-scratch-message nil)
(add-hook 'emacs-startup-hook (lambda () (message "")))

;; prefer utf-8
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; disable fancy ui
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; common editor feature
(show-paren-mode 1)
(global-display-line-numbers-mode 1)

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

(require 'core)
(require 'extensions)
(require 'languages)

;; load config managed by "customize"
(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(el-get 'sync)
;;; init.el ends here

