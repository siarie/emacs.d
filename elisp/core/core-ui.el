;;; core-ui.el --- Core UI
;;
;;; Commentary:
;;
;;; Code:

;; disable fancy ui
(menu-bar-mode -1)
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;; Color Theme
(straight-use-package 'modus-themes)
(load-theme 'modus-vivendi-deuteranopia :no-confirm)

(set-face-attribute 'default nil
                    :family "Inconsolata"
                    :height 120
                    :weight 'normal)

;; highlight current line
(global-hl-line-mode 1)

;; change cursor
(setq-default cursor-type 'bar)

(provide 'core-ui)

;;; core-ui.el ends here
