;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2015/06/30.21:00:01


;;==================================================================================================
;; omnisharp setup                                                                                    
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(require 'omnisharp nil t)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------



(require 'csharp-mode)


(defun omnisharp-async-autocomplete-autotrigger ()
  (interactive)
  (omnisharp-add-dot-and-auto-complete))


(add-hook 'csharp-mode-hook '(lambda ()
                               (auto-complete-mode)
                               (omnisharp-mode)
                               (local-set-key (kbd ".") 'omnisharp-async-autocomplete-autotrigger)
                               ))
;; (add-hook 'csharp-mode-hook 'omnisharp-mode)

;; (setq omnisharp--curl-executable-path "c:/cygwin-x86_64/usr/local/bin/_curl.exe")
(setq omnisharp--curl-executable-path "c:/cygwin-x86_64/usr/local/bin/curl.exe")
;; (setq omnisharp-server-executable-path "c:/cygwin-x86_64/tmp/omnisharp-server/OmniSharp/bin/Release/OmniSharp.exe")
(setq omnisharp-server-executable-path "c:/cygwin-x86_64/tmp/omnisharp-server/OmniSharp/bin/Debug/OmniSharp.exe")





(provide 'setup.omnisharp)
;;--------------------------------------------------------------------------------------------------
;; EOF
