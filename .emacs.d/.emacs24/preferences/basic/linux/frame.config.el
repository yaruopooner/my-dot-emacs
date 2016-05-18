;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2016/05/19.01:26:03


;;==============================================================================
;; Frame Environment                                                            
;; for linux                                                                    
;;==============================================================================


(setq default-frame-alist (append '(
                                    (left    . 70)                                  ;左上点のＸ座標
                                    (top     . 15)                                  ;左上点のＹ座標
                                    (width   . 250)                                 ;横幅
                                    (height  . 70)                                  ;縦幅
                                    ;; (frame-pixel-width . 300)                       ;横幅
                                    ;; (frame-pixel-height . 180)                      ;縦幅
                                    )
                                  default-frame-alist))





(provide 'linux/frame.config)
;;------------------------------------------------------------------------------
;; EOF
