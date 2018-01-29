;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Melpa init
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; Override package manager with paradox
(require 'paradox)
(paradox-enable)

;; <NOT WORKING> Use polymode for Rnw file 
(require 'poly-R)
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))

;; ESS init
(require 'ess-site)

;; Evil init
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

;; Set inferior lisp
(setq inferior-lisp-program "sbcl")

;; Company-mode for all
(global-company-mode)

;; Enable SLIME company-mode
(slime-setup '(slime-company))

;; Enable rainbow  delimiters for most programming modes
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; SLIME SBCL helper init
(load (expand-file-name "~/quicklisp/slime-helper.el"))

;; AucTeX syncTeX init
(setq TeX-source-correlate-mode t
      TeX-source-correlate-start-server t)

;; Change the order of pdflatex commands
(setq ess-swv-pdflatex-commands (quote ("pdflatex" "texi2pdf" "make")))

;; Change default sweave processor to Knitr
(setq ess-swv-processor 'knitr)

;; <NOT WORKING> Enable automatically AUCTeX ESS plug
(require 'ess-site)
(with-eval-after-load "ess"
  (setq ess-swv-plug-into-AUCTeX-p t))

;; Fix constant error spam
(defun ess-noweb-post-command-function ()
  "The hook being run after each command in noweb mode."
  (condition-case err
      (ess-noweb-select-mode)
    (error 
     ())))

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
    (unless (member (car x) swv-cmds) x)))

;; Set default PDF viewer
(eval-after-load "tex"
  '(add-to-list 'TeX-view-program-selection
	       '(output-pdf "Zathura")))

;; Macros to quickly knitr and latex
(with-eval-after-load "latex"
  (define-key LaTeX-mode-map (kbd "C-c C-d") (kbd "C-c C-c Knit RET")))
(with-eval-after-load "latex"
  (define-key LaTeX-mode-map (kbd "C-c C-q") (kbd "C-c C-c LaTeXKnit RET")))

;; Turn flyspell for latex documents
(with-eval-after-load "latex"
  (add-hook 'LaTeX-mode-hook 'flyspell-mode))

;; Sane amount of scroll
(setq mouse-wheel-scroll-amount '(1))
(setq mouse-wheel-progressive-speed nil)

;; Bind magit
(global-set-key (kbd "C-x g") 'magit-status)

;; Check spelling only every minute or so
(require 'flyspell-lazy)
(flyspell-lazy-mode 1)

(setq TeX-parse-self t) ; Enable parse on load
(setq TeX-auto-save t) ; Enable parse on save
(setq TeX-auto-untabify t) ; Auto change tabs to spaces

;; Set flyspell dictionary language
(add-hook 'TeX-language-pl-hook
	  (lambda () (ispell-change-dictionary "polish")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(package-selected-packages
   (quote
    (flyspell-lazy ess markdown-mode async auctex evil-magit magit evil ## polymode paradox)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monaco" :foundry "unknown" :slant normal :weight normal :height 141 :width normal)))))
