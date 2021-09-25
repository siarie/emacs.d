;;; core-bindings.el --- default key binding

;; replace buffer with IBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; global comment/uncomment key binding
(global-set-key (kbd "C-c C-;") 'comment-or-uncomment-region)

;; use cua-mode; kang'ed from: https://www.emacswiki.org/emacs/CuaMode
(cua-mode t)
;; Don't tabify after rectangle commands
(setq cua-auto-tabify-rectangles nil)
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

(provide 'core-bindings)

;;; core-bindings.el ends here
