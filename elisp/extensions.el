;;; extensions.el

;;; Code:

(add-to-list
 'load-path
 (expand-file-name "extensions" (file-name-directory load-file-name)))

;; eglot
(straight-use-package 'eglot)

;; diminish
(straight-use-package 'diminish)

;; yasnippet
(straight-use-package 'yasnippet)
(yas-global-mode)

(straight-use-package 'pinentry)

;; require modules
(require 'x-company)
(require 'x-editorconfig)
(require 'x-magit)
(require 'x-projectile)
;; (require 'x-rainbow)
(require 'x-swiper)
(require 'x-which-key)


(straight-use-package 'notmuch)

(provide 'extensions)

;;; extensions.el ends here
