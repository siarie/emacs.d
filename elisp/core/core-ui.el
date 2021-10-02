;;; core-ui.el --- Core UI
;;
;;; Commentary:
;;
;;; Code:


;; disable fancy ui
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; enable theme
(load-theme 'wombat)

(set-face-attribute 'default nil
                    :family "Iosevka"
                    :height 100
		            :weight 'normal)

(set-face-attribute 'font-lock-comment-face nil
		            :slant 'italic)

(set-face-attribute 'font-lock-keyword-face nil
		            :weight 'bold)

;; highlight current line
(global-hl-line-mode 1)

;; change cursor
(setq-default cursor-type 'bar)
(set-cursor-color "#ffffff")

(provide 'core-ui)

;;; core-ui.el ends here
