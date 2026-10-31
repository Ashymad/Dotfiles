;; (package-initialize)  -*- lexical-binding: t; -*-

;; Sane amount of scroll
(setq mouse-wheel-scroll-amount '(3))
(setq mouse-wheel-progressive-speed nil)
(setq scroll-conservatively 10
            scroll-margin 15)

;; Enable mouse in terminal
(add-hook 'after-make-frame-functions (lambda (f) (xterm-mouse-mode 1) (mouse-wheel-mode 1))) 

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

;; Emacs terminal
(use-package eat
 :straight
 '(eat :type git
       :host codeberg
       :repo "akib/emacs-eat"
       :files ("*.el" ("term" "term/*.el") "*.texi"
	       "*.ti" ("terminfo/e" "terminfo/e/*")
	       ("terminfo/65" "terminfo/65/*")
	       ("integration" "integration/*")
	       (:exclude ".dir-locals.el" "*-tests.el"))))

(use-package autothemer)
(use-package rose-pine-theme
  :straight
  `(rose-pine-theme
    :host github
    :repo "konrad1977/pinerose-emacs"
    :branch "main"))

(load-theme 'rose-pine t)

;; Trasparent background
(defun set-background-for-terminal (&optional frame)
  (or frame (setq frame (selected-frame)))
  "unsets the background color in terminal mode"
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))
(add-hook 'after-make-frame-functions 'set-background-for-terminal)
(add-hook 'window-setup-hook 'set-background-for-terminal)

;; Enable Corfu completion UI
(use-package corfu
  :hook (after-init . global-corfu-mode))

;; Add extensions
(use-package cape
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

(setq tab-always-indent 'complete)
(setq text-mode-ispell-word-completion nil)
(setq read-extended-command-predicate #'command-completion-default-include-p)
