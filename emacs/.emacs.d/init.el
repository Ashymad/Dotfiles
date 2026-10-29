;; (package-initialize)  -*- lexical-binding: t; -*-

;; Sane amount of scroll
(setq mouse-wheel-scroll-amount '(3))
(setq mouse-wheel-progressive-speed nil)

;; Relnum
(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)

;; Turn off menu
(menu-bar-mode -1)

;; Always follow symlinks
(setq vc-follow-symlinks t)

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
	"straight/repos/straight.el/bootstrap.el"
	(or (bound-and-true-p straight-base-dir)
	    user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage))

;; Setup use-package with straight.el
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Initialize Evil
(use-package evil
  :config
  ;; Global evil mode
  (evil-mode 1))

(use-package raku-mode)

(use-package autothemer)

(use-package rose-pine-theme
  :straight
  `(rose-pine-theme
    :host github
    :repo "konrad1977/pinerose-emacs"
    :branch "main"))

(load-theme 'rose-pine t)
(defun set-background-for-terminal (&optional frame)
  (or frame (setq frame (selected-frame)))
  "unsets the background color in terminal mode"
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))
(add-hook 'after-make-frame-functions 'set-background-for-terminal)
(add-hook 'window-setup-hook 'set-background-for-terminal)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
