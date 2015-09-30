;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/03/30.04:27:44

;;==============================================================================
;; Font Lock :: User Face Create                                                
;;==============================================================================


(defun user-face-00-create ()
    "User Face Create"
    (interactive)
    (require 'font-lock)

;;------------------------------------------------------------------------------
;; font-lock を使用した face の作成                                             
; face の実体作成                                                               
; 関数 make-face により作成し、face の属性を設定する。                          
; 属性は set-face- という接頭辞を持つ関数により行う。                           
;                                                                               
;    (make-face '_user-face_xxxx_yyyy_zzzz)                                     
;    (set-face-foreground '_user-face_xxxx_yyyy_zzzz "#0000ff")                 
;    (set-face-background '_user-face_xxxx_yyyy_zzzz nil)                       
;    (set-face-bold-p '_user-face_xxxx_yyyy_zzzz t)                             
;    (set-face-italic-p '_user-face_xxxx_yyyy_zzzz nil)                         
;    (set-face-underline-p '_user-face_xxxx_yyyy_zzzz nil)                      
;                                                                               
; face 実体指定の変数                                                           
; 変数に face への symbol を設定します。                                        
;   (setq user-face_xxxx_yyyy_zzzz '_user-face_xxxx_yyyy_zzzz)                  
;                                                                               
;;------------------------------------------------------------------------------
;; user 側での prefix の取り決め（見やすいから・・）                            
; face 定義は _hoge-hoge  :: instance は hoge-hoge                              
; _xxxx :: mode name                                                            
; _yyyy :: target name                                                          
; _zzzz :: misc name (在れば)                                                   
;                                                                               
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;; cc-mode :: type-identifier
    (make-face '_user-face_cc-mode_type-identifier)
    (set-face-foreground '_user-face_cc-mode_type-identifier ect-face-fgc-cc-mode_type-identifier)
    (set-face-background '_user-face_cc-mode_type-identifier ect-face-bgc-cc-mode_type-identifier)
    (set-face-bold-p '_user-face_cc-mode_type-identifier t)
    (set-face-italic-p '_user-face_cc-mode_type-identifier nil)
    (set-face-underline-p '_user-face_cc-mode_type-identifier nil)

    (setq user-face_cc-mode_type-identifier '_user-face_cc-mode_type-identifier)

;;------------------------------------------------------------------------------
;; cc-mode :: type-specifier-0 
    (make-face '_user-face_cc-mode_type-specifier-0)
    (set-face-foreground '_user-face_cc-mode_type-specifier-0 ect-face-fgc-cc-mode_type-specifier-0)
    (set-face-background '_user-face_cc-mode_type-specifier-0 ect-face-bgc-cc-mode_type-specifier-0)
    (set-face-bold-p '_user-face_cc-mode_type-specifier-0 t)
    (set-face-italic-p '_user-face_cc-mode_type-specifier-0 nil)
    (set-face-underline-p '_user-face_cc-mode_type-specifier-0 nil)

    (setq user-face_cc-mode_type-specifier-0 '_user-face_cc-mode_type-specifier-0)

;;------------------------------------------------------------------------------
;; cc-mode :: type-specifier-1 
    (make-face '_user-face_cc-mode_type-specifier-1)
    (set-face-foreground '_user-face_cc-mode_type-specifier-1 ect-face-fgc-cc-mode_type-specifier-1)
    (set-face-background '_user-face_cc-mode_type-specifier-1 ect-face-bgc-cc-mode_type-specifier-1)
    (set-face-bold-p '_user-face_cc-mode_type-specifier-1 t)
    (set-face-italic-p '_user-face_cc-mode_type-specifier-1 nil)
    (set-face-underline-p '_user-face_cc-mode_type-specifier-1 nil)

    (setq user-face_cc-mode_type-specifier-1 '_user-face_cc-mode_type-specifier-1)

;;------------------------------------------------------------------------------
;; cc-mode :: type-qualifier 
    (make-face '_user-face_cc-mode_type-qualifier)
    (set-face-foreground '_user-face_cc-mode_type-qualifier ect-face-fgc-cc-mode_type-qualifier)
    (set-face-background '_user-face_cc-mode_type-qualifier ect-face-bgc-cc-mode_type-qualifier)
    (set-face-bold-p '_user-face_cc-mode_type-qualifier t)
    (set-face-italic-p '_user-face_cc-mode_type-qualifier nil)
    (set-face-underline-p '_user-face_cc-mode_type-qualifier nil)

    (setq user-face_cc-mode_type-qualifier '_user-face_cc-mode_type-qualifier)
    
;;------------------------------------------------------------------------------
;; cc-mode :: Variable 
    (make-face '_user-face_cc-mode_variable)
    (set-face-foreground '_user-face_cc-mode_variable ect-face-fgc-cc-mode_variable)
    (set-face-background '_user-face_cc-mode_variable ect-face-bgc-cc-mode_variable)
    (set-face-bold-p '_user-face_cc-mode_variable t)
    (set-face-italic-p '_user-face_cc-mode_variable nil)
    (set-face-underline-p '_user-face_cc-mode_variable nil)

    (setq user-face_cc-mode_variable '_user-face_cc-mode_variable)

;;------------------------------------------------------------------------------
;; cc-mode :: Structure 
    (make-face '_user-face_cc-mode_structure)
    (set-face-foreground '_user-face_cc-mode_structure ect-face-fgc-cc-mode_structure)
    (set-face-background '_user-face_cc-mode_structure ect-face-bgc-cc-mode_structure)
    (set-face-bold-p '_user-face_cc-mode_structure t)
    (set-face-italic-p '_user-face_cc-mode_structure nil)
    (set-face-underline-p '_user-face_cc-mode_structure nil)

    (setq user-face_cc-mode_structure '_user-face_cc-mode_structure)

;;------------------------------------------------------------------------------
;; cc-mode :: Class 
    (make-face '_user-face_cc-mode_class)
    (set-face-foreground '_user-face_cc-mode_class ect-face-fgc-cc-mode_class)
    (set-face-background '_user-face_cc-mode_class ect-face-bgc-cc-mode_class)
    (set-face-bold-p '_user-face_cc-mode_class nil)
    (set-face-italic-p '_user-face_cc-mode_class nil)
    (set-face-underline-p '_user-face_cc-mode_class nil)

    (setq user-face_cc-mode_class '_user-face_cc-mode_class)

;;------------------------------------------------------------------------------
;; cc-mode :: Preprocessor 
    (make-face '_user-face_cc-mode_preprocessor)
    (set-face-foreground '_user-face_cc-mode_preprocessor ect-face-fgc-cc-mode_preprocessor)
    (set-face-background '_user-face_cc-mode_preprocessor ect-face-bgc-cc-mode_preprocessor)
    (set-face-bold-p '_user-face_cc-mode_preprocessor t)
    (set-face-italic-p '_user-face_cc-mode_preprocessor nil)
    (set-face-underline-p '_user-face_cc-mode_preprocessor nil)

    (setq user-face_cc-mode_preprocessor '_user-face_cc-mode_preprocessor)

;;------------------------------------------------------------------------------
;; cc-mode :: Comment 
    (make-face '_user-face_cc-mode_comment)
    (set-face-foreground '_user-face_cc-mode_comment ect-face-fgc-cc-mode_comment)
    (set-face-background '_user-face_cc-mode_comment ect-face-bgc-cc-mode_comment)
    (set-face-bold-p '_user-face_cc-mode_comment t)
    (set-face-italic-p '_user-face_cc-mode_comment nil)
    (set-face-underline-p '_user-face_cc-mode_comment nil)

    (setq user-face_cc-mode_comment '_user-face_cc-mode_comment)

;;------------------------------------------------------------------------------
;; cc-mode :: float Register 
    (make-face '_user-face_cc-mode_register_float)
    (set-face-foreground '_user-face_cc-mode_register_float ect-face-fgc-cc-mode_register_float)
    (set-face-background '_user-face_cc-mode_register_float ect-face-bgc-cc-mode_register_float)
    (set-face-bold-p '_user-face_cc-mode_register_float nil)
    (set-face-italic-p '_user-face_cc-mode_register_float nil)
    (set-face-underline-p '_user-face_cc-mode_register_float nil)

    (setq user-face_cc-mode_register_float '_user-face_cc-mode_register_float)

;;------------------------------------------------------------------------------
;; cc-mode :: int Register 
    (make-face '_user-face_cc-mode_register_int)
    (set-face-foreground '_user-face_cc-mode_register_int ect-face-fgc-cc-mode_register_int)
    (set-face-background '_user-face_cc-mode_register_int ect-face-bgc-cc-mode_register_int)
    (set-face-bold-p '_user-face_cc-mode_register_int nil)
    (set-face-italic-p '_user-face_cc-mode_register_int nil)
    (set-face-underline-p '_user-face_cc-mode_register_int nil)

    (setq user-face_cc-mode_register_int '_user-face_cc-mode_register_int)

;;------------------------------------------------------------------------------
;; cc-mode :: Special Register (gp, sp, fp, ra, PC, zero, .....misc)
    (make-face '_user-face_cc-mode_register_special)
    (set-face-foreground '_user-face_cc-mode_register_special ect-face-fgc-cc-mode_register_special)
    (set-face-background '_user-face_cc-mode_register_special ect-face-bgc-cc-mode_register_special)
    (set-face-bold-p '_user-face_cc-mode_register_special t)
    (set-face-italic-p '_user-face_cc-mode_register_special nil)
    (set-face-underline-p '_user-face_cc-mode_register_special nil)

    (setq user-face_cc-mode_register_special '_user-face_cc-mode_register_special)

;;------------------------------------------------------------------------------
;; cc-mode :: Condition Register (.....misc)
    (make-face '_user-face_cc-mode_register_condition)
    (set-face-foreground '_user-face_cc-mode_register_condition ect-face-fgc-cc-mode_register_condition)
    (set-face-background '_user-face_cc-mode_register_condition ect-face-bgc-cc-mode_register_condition)
    (set-face-bold-p '_user-face_cc-mode_register_condition t)
    (set-face-italic-p '_user-face_cc-mode_register_condition nil)
    (set-face-underline-p '_user-face_cc-mode_register_condition nil)

    (setq user-face_cc-mode_register_condition '_user-face_cc-mode_register_condition)

)





(provide 'user-face-00)
;;------------------------------------------------------------------------------
;; EOF
