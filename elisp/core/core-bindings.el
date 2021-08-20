;;; core-bindings.el --- default key binding

;; replace buffer with IBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; global comment/uncomment key binding
(global-set-key (kbd "C-c C-;") 'comment-or-uncomment-region)

(provide 'core-bindings)

;;; core-bindings.el ends here
