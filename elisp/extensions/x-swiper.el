;;; x-swiper.el --- Swipper, Ivy, and counsel configurations

;;; Code:

(straight-use-package 'swiper)

(ivy-mode 1)
(global-set-key (kbd "C-x s") 'swiper)

(diminish 'ivy-mode)

(provide 'x-swiper)

;;; x-swiper.el ends here
