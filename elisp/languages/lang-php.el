;;; lang-php.el --- PHP language support

;;; Code:

(straight-use-package 'php-mode)

(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(defun lang/php-mode--setup ()
  "PHP mode setup."
  (php-enable-default-coding-style)
  (setq indent-tabs-mode nil
		fill-column 72))

;; php-mode hook
(add-hook 'php-mode-hook 'lang/php-mode--setup)

(provide 'lang-php)

;;; lang-php.el ends here
