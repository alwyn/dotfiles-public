;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Alwyn Schoeman"
      user-mail-address "alwyn.schoeman@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;

;; (setq font-family "Iosevka Nerd Font Mono")
(setq font-family "Iosevka")
(setq font-weight 'normal)

(cond
  ((display-pixel-width 7680)   ;; This is 1440k 27" external scaled to 4k
   (progn (setq font-size-regular 30) (setq font-size-large 40)))
  ((display-pixel-width 1920)
   (progn (setq font-size-regular 12) (setq font-size-large 16)))
  (t (progn (setq font-size-regular 12) (setq font-size-large 16))))

(setq doom-font (font-spec :family font-family :size font-size-regular :weight font-weight)
    doom-variable-pitch-font (font-spec :family font-family :size font-size-regular :weight font-weight)
    (doom-font-big (font-spec :family font-family :size font-size-large :weight font-weight))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; This is so that in org mode the // and ** are not visible
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq exec-path (append exec-path '("/home/alwyn/.sdkman/candidates/leiningen/current/bin")))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(after! org
  (setq org-agenda-files '("~/org/gtd")
        org-hide-emphasis-markers t
        org-refile-targets '(("~/org/gtd/gtd.org" :maxlevel . 2))))

(use-package! org-roam
  :defer t
  :custom
  (org-roam-directory "~/roam")
  (org-roam-index-file "~/roam/index.org")
  :config
  (org-roam-setup)
  (require 'org-roam-protocol))

(setq org-plantuml-jar-path (expand-file-name "/home/alwyn/.doom.d/plantuml-1.2022.12.jar"))
(setq plantuml-jar-path (expand-file-name "/home/alwyn/.doom.d/plantuml-1.2022.12.jar"))
(setq plantuml-default-exec-mode 'jar)  ;;Necessary to render in the buffer

(after! org
        (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
        (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t))))

(add-to-list 'auto-mode-alist '("\\.ldg$" . ledger-mode))

;; Need to still test this
(after! evil-ledger
  (setq evil-ledger-sort-key "S"))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
