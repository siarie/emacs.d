;;; lang-php.el --- PHP language support

(el-get-bundle php-mode
  :load-path "lisp/")
(el-get-bundle company-php in xcwen/ac-php
  :name company-php
  :depends (s f xcscope yasnippet php-mode popup))

(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

;; php-mode hook
(add-hook 'php-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil
		  fill-column 78)
	    (setq-local company-backends
			'((company-ac-php-backend :with company-yasnippet)))))

(provide 'lang-php)

;;; lang-php.el ends here

