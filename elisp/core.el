;;; core.el --- load core modules

(add-to-list
 'load-path
 (expand-file-name "core" (file-name-directory load-file-name)))

(require 'core-bindings)
(require 'core-ui)
 
(provide 'core)

;;; core.el ends here

