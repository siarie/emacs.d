;;; core-ui.el --- Core UI

;;; Commentary:

(set-face-attribute 'default nil
                    :height 100
		    :weight 'normal)

(set-face-attribute 'font-lock-keyword-face nil
		    :weight 'bold)

;; highlight current line
(global-hl-line-mode 1)

(provide 'core-ui)

;;; core-ui.el ends here
