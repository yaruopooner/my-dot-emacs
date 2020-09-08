;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2020/09/09.02:24:17


;;==============================================================================
;; .emacs (Emacs & Meadow)                                                      
;;==============================================================================


;; window-system is embedded variable 
;; Value | Type
;;-------+---------
;; nil   for a termcap frame (a character-only terminal),
;; 'x'   for an Emacs frame that is really an X window,
;; 'w32' for an Emacs frame that is a window on MS-Windows display,
;; 'ns'  for an Emacs frame on a GNUstep or Macintosh Cocoa display,
;; 'pc'  for a direct-write MS-DOS frame.


;; system-type is embedded variable
;; Value | Type
;;-------+---------
;; `gnu'          compiled for a GNU Hurd system.
;; `gnu/linux'    compiled for a GNU/Linux system.
;; `gnu/kfreebsd' compiled for a GNU system with a FreeBSD kernel.
;; `darwin'       compiled for Darwin (GNU-Darwin, Mac OS X, ...).
;; `ms-dos'       compiled as an MS-DOS application.
;; `windows-nt'   compiled as a native W32 application.
;; `cygwin'       compiled using the Cygwin library.


;; (emacs-type)
;; Value     | Info
;; ----------+---------
;; emacs     | GUI Emacs
;; meadow    | Meadow
(defconst de:emacs-type (if (functionp 'Meadow-version) 'meadow 'emacs))




;;==============================================================================
;; Environment Variable                                                         
;;==============================================================================


;; Emacs | Mule & Meadow Check
(defconst _user_emacs-type-check (null (functionp 'Meadow-version)))


;; Emacs Directory Path
(defconst de:path-emacs (expand-file-name "../" invocation-directory))

;; Emacs site-lisp Directory path
(defconst de:path-emacs-site-lisp (expand-file-name "site-lisp/" de:path-emacs))


;; User Emacs Directory Root Path
(defconst de:path-dot-emacs-root (if (boundp 'user-emacs-directory) (symbol-value 'user-emacs-directory) (file-name-directory (or (buffer-file-name) load-file-name))))

;; Emacs メジャーバージョンを判別、各バージョン用ディレクトリを User Emacs Directory とする
;(defconst de:rpath-dot-emacs (replace-regexp-in-string "^\\([0-9]+\\)\\(\\.[0-9]+\\)+" ".emacs\\1/" emacs-version))
(defconst de:rpath-dot-emacs (format ".emacs%d/" emacs-major-version))
(defconst de:path-dot-emacs (expand-file-name de:rpath-dot-emacs de:path-dot-emacs-root))



;; proxy server 
(require 'url)

(let ((proxies '(("http" . "http_proxy")
                 ("https" . "https_proxy")))
      (pattern-format "\\(?:%s://\\)?\\(.+\\)$")
      pattern
      url)
  (dolist (proxy proxies)
    (setq url (getenv (cdr proxy)))
    (setq pattern (format pattern-format (car proxy)))
    (when (and url (string-match pattern url))
      (add-to-list 'url-proxy-services `(,(car proxy) . ,(match-string 1 url))))))




;;==============================================================================
;; Utility Functions
;;==============================================================================


(require 'bytecomp)

(defun de:auto-byte-compile (byte-compile-src)
  (when (file-readable-p byte-compile-src)
    (let ((byte-compile-dest (byte-compile-dest-file byte-compile-src)))
      (when (file-newer-than-file-p byte-compile-src byte-compile-dest)
        (byte-compile-file byte-compile-src)))))



;;==============================================================================
;; load-path                                                                    
;;==============================================================================

;; warning supress for 'Pckage cl is deprecated' 
(setq byte-compile-warnings '(cl-functions))


(add-to-list 'load-path de:path-dot-emacs)

(de:auto-byte-compile (expand-file-name "emacs.el" de:path-dot-emacs))
(load-library (expand-file-name "emacs" de:path-dot-emacs))



;;==============================================================================
;; User Emacs Environment                                                       
;;==============================================================================

;; EOF
