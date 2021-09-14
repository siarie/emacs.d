;;; core-ui.el --- Core UI
;;
;;; Commentary:
;;
;;; Code:

(load-theme 'wombat)

(set-face-attribute 'default nil
                    :height 100
		            :weight 'normal)

(set-face-attribute 'font-lock-comment-face nil
		            :slant 'italic)

(set-face-attribute 'font-lock-keyword-face nil
		            :weight 'bold)

;; disable fancy ui
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; highlight current line
(global-hl-line-mode 1)


(provide 'core-ui)

;;; core-ui.el ends here
