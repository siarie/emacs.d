;;; languages.el --- lang mode

(add-to-list
 'load-path
 (expand-file-name "languages" (file-name-directory load-file-name)))

(require 'lang-javascript) ;; javascript & typescript
(require 'lang-go)
(require 'lang-markdown)
(require 'lang-org)
(require 'lang-php)
(require 'lang-python)
(require 'lang-web)
(require 'lang-zig)

(provide 'languages)

;;; languages.el ends here
