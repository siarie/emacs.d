;;; languages.el --- lang mode

(add-to-list
 'load-path
 (expand-file-name "languages" (file-name-directory load-file-name)))

(require 'lang-javascript)
(require 'lang-go)
(require 'lang-php)
(require 'lang-python)
(require 'lang-web)

(provide 'languages)

;;; languages.el ends here
