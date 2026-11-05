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

(defun my-display-numbers-hook ()
    (display-line-numbers-mode 1))

(add-hook 'prog-mode-hook 'my-display-numbers-hook)
(add-hook 'text-mode-hook 'my-display-numbers-hook)
(add-hook 'conf-mode-hook 'my-display-numbers-hook)

(defun swap-buffer () (switch-to-buffer (other-buffer)))

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
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

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

(use-package treemacs
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
		 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
	("M-0"       . treemacs-select-window)
	("C-x t 1"   . treemacs-delete-other-windows)
	("C-x t t"   . treemacs)
	("C-x t d"   . treemacs-select-directory)
	("C-x t B"   . treemacs-bookmark)
	("C-x t C-t" . treemacs-find-file)
	("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil))

(treemacs-start-on-boot)

(setq tab-always-indent 'complete)
(setq text-mode-ispell-word-completion nil)
(setq read-extended-command-predicate #'command-completion-default-include-p)

(global-set-key (kbd "C-^") 'swap-buffer)
