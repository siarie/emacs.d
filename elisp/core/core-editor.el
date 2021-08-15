;;; core-editor.el --- Editor Settings

;;; Code:

;; prefer utf-8
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; disable backup
(setq make-backup-files nil)

;; show matching paren
(show-paren-mode 1)

;; global line numbers
(global-display-line-numbers-mode 1)

;; final newline
(setq require-final-newline t)
(setq next-line-add-newlines nil)

;; use space instead of tab
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; ask y or n instead yes or no
(defalias 'yes-or-no-p 'y-or-n-p)

(provide 'core-editor)

;;; core-editor.el ends here
