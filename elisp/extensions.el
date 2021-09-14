;;; extensions.el

;;; Code:

(add-to-list
 'load-path
 (expand-file-name "extensions" (file-name-directory load-file-name)))

;; diminish
(el-get-bundle diminish)

;; yasnippet
(el-get-bundle yasnippet)
(yas-global-mode)
;; (diminish 'yasnippet)

;; require modules
(require 'x-company)
(require 'x-editorconfig)
(require 'x-magit)
(require 'x-projectile)
(require 'x-rainbow)
(require 'x-swiper)
(require 'x-which-key)

(provide 'extensions)

;;; extensions.el ends here
