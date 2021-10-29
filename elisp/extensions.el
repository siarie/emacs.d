;;; extensions.el

;;; Code:

(add-to-list
 'load-path
 (expand-file-name "extensions" (file-name-directory load-file-name)))

;; eglot
(straight-use-package 'eglot)

;; yasnippet
(straight-use-package 'yasnippet)
(yas-global-mode)

(straight-use-package 'pinentry)
(straight-use-package 'notmuch)

;; diminish
(straight-use-package 'diminish)
(diminish 'auto-fill-function)
(diminish 'eldoc-mode)
(diminish 'yas-minor-mode)


;; require modules
(require 'x-company)
(require 'x-editorconfig)
(require 'x-magit)
;; (require 'x-projectile)
;; (require 'x-rainbow)
(require 'x-swiper)
(require 'x-which-key)

(provide 'extensions)

;;; extensions.el ends here
