;; (package-initialize)

;; Sane amount of scroll
(setq mouse-wheel-scroll-amount '(3))
(setq mouse-wheel-progressive-speed nil)

;; Setup package.el
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Initialize use-package
(require 'use-package)

;; Recompile emacs.d
(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)

;; Initialize Paradox
(use-package paradox
  :config
  ;; Override default package manager with paradox
  (paradox-enable))

;; Initialize Evil
(use-package evil
  :config
  ;; Global evil mode
  (evil-mode 1))

;; Initialize magit
(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status))

;; Initialize evil-magit
(use-package evil-magit
  :requires
  (evil magit))

;; Initialize AUCTeX
(use-package tex
  :hook 
  (TeX-language-pl . (lambda () (ispell-change-dictionary "polish")))
  (LaTeX-mode . flyspell-mode)
  :init
  (setq TeX-source-correlate-mode t
	TeX-source-correlate-start-server t
	TeX-parse-self t ; Enable parse on load
	TeX-auto-save t ; Enable parse on save
	TeX-auto-untabify t) ; Auto change tabs to spaces
  :config
  ;; Set default PDF viewer
  (add-to-list 'TeX-view-program-selection
	       '(output-pdf "Zathura")))

(use-package flyspell-lazy
  :config
  (flyspell-lazy-mode 1))

;; Initalize ESS
(use-package ess-site
  :hook
  (ess-noweb-mode . (lambda () (if (not ess-swv-plug-into-AUCTeX-p)
				   (ess-swv-toggle-plug-into-AUCTeX))))
  :config
  (setq ess-swv-pdflatex-commands (quote ("pdflatex" "texi2pdf" "make")))
  (setq ess-swv-processor 'knitr)
  ;; Change AUCTeX Sweave commands to Knitr
  (defun ess-swv-add-TeX-commands ()
    "Add commands to AUCTeX's \\[TeX-command-list]."
    (unless (and (featurep 'tex-site) (featurep 'tex))
      (error "AUCTeX does not seem to be loaded"))
    (add-to-list 'TeX-command-list
		 '("Knit" "Rscript -e \"library(knitr); knit('%t')\""
		   TeX-run-command nil (latex-mode) :help
		   "Run Knitr") t)
    (add-to-list 'TeX-command-list
		 '("LaTeXKnit" "%l %(mode) %s; Rscript -e \"require('patchSynctex'); patchSynctex('%s')\""
		   TeX-run-TeX nil (latex-mode) :help
		   "Run LaTeX after Knit") t)
    (setq TeX-command-default "Knit")
    (mapc (lambda (suffix)
	    (add-to-list 'TeX-file-extensions suffix))
	  '("nw" "Snw" "Rnw")))
  (defun ess-swv-remove-TeX-commands (x)
    "Helper function: check if car of X is one of the Knitr strings"
    (let ((swv-cmds '("Knit" "LaTeXKnit")))
      (unless (member (car x) swv-cmds) x))))

;; Initialize company-mode
(use-package company
  :config
  (global-company-mode))

;; Initialize SLIME
(use-package slime
  :init
  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  (setq inferior-lisp-program "sbcl"))
  
;; Initialize slime-company
(use-package slime-company
  :requires
  (slime company)
  :config
  (slime-setup '(slime-company)))

;; Initialize rainbow-delimiters
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

;; Initialize zerodark theme
(use-package zerodark-theme
  :config
  (zerodark-setup-modeline-format))

;; Initialize hy-mode
(use-package hy-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.hy\\'" . hy-mode)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#282c34" "#ff6c6b" "#98be65" "#da8548" "#61afef" "#c678dd" "#1f5582" "#abb2bf"])
 '(custom-enabled-themes (quote (zerodark)))
 '(custom-safe-themes
   (quote
    ("f142c876b896c6ca19149cacd80ddd68a351f67f7fe3b786274ceee970276780" default)))
 '(package-selected-packages
   (quote
    (hy-mode slime slime-company use-package rainbow-delimiters zerodark-theme wc-mode flyspell-lazy ess markdown-mode async auctex evil-magit magit evil ## paradox)))
 '(paradox-github-token t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "CTDB" :slant normal :weight normal :height 143 :width normal)))))
