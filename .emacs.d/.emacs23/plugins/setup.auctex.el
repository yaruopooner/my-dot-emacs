;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/04/25.03:40:25


;;==================================================================================================
;; AUCTeX setup                                                                                    
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


;; load path addition
(add-to-list 'load-path (expand-file-name "auctex/site-lisp/site-start.d/" path-plugins))


(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)





;;------------------------------------------------------------------------------
;; basic setting                                                                
;;------------------------------------------------------------------------------


(setq TeX-default-mode 'japanese-latex-mode)
(setq japanese-LaTeX-default-style "jsarticle")
(setq japanese-LaTeX-command-default "pLaTeX")
(setq TeX-engine-alist '((ptex "pTeX" "eptex" "platex" "eptex")
                         (uptex "upTeX" "euptex" "uplatex" "euptex")))
(setq TeX-engine 'ptex)
(setq TeX-view-program-list '(("dviout" "C:/w32tex/dviout/dviout -1 %d \"# %n '%b'\"")
                              ("TeXworks" "C:/w32tex/share/texworks/TeXworks %o")
                              ("SumatraPDF" "\"C:/Program Files/SumatraPDF/SumatraPDF\" -reuse-instance %o -forward-search \"%b\" %n")
                              ("pdfopen" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde & pdfopen --file %o")))
(setq TeX-view-program-selection '((output-dvi "dviout")
                                   (output-pdf "TeXworks")))
(setq preview-image-type 'dvipng)

(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook
          (function (lambda ()
                      (TeX-source-correlate-mode 1)
                      (setq TeX-source-correlate-start-server t)
                      (add-to-list 'TeX-command-list
                                   '("pdfpLaTeX" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde & platex -kanji=utf8 -guess-input-enc -synctex=1 -jobname=%s %t && dvipdfmx %d"
                                     TeX-run-TeX nil (latex-mode) :help "Run e-pLaTeX and dvipdfmx"))
                      (add-to-list 'TeX-command-list
                                   '("pdfpLaTeX2" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde & platex -kanji=utf8 -guess-input-enc -synctex=1 -jobname=%s %t && dvips -Ppdf -t a4 -z -f %d | convbkmk -g > %f && ps2pdf.bat %f"
                                     TeX-run-TeX nil (latex-mode) :help "Run e-pLaTeX, dvips, and ps2pdf"))
                      (add-to-list 'TeX-command-list
                                   '("pdfupLaTeX" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde & uplatex -kanji=utf8 -no-guess-input-enc -synctex=1 %t && dvipdfmx %d"
                                     TeX-run-TeX nil (latex-mode) :help "Run e-upLaTeX and dvipdfmx"))
                      (add-to-list 'TeX-command-list
                                   '("pdfupLaTeX2" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde & uplatex -kanji=utf8 -no-guess-input-enc -synctex=1 %t && dvips -Ppdf -t a4 -z -f %d | convbkmk -u > %f && ps2pdf.bat %f"
                                     TeX-run-TeX nil (latex-mode) :help "Run e-upLaTeX, dvips, and ps2pdf"))
                      (add-to-list 'TeX-command-list
                                   '("pBibTeX" "pbibtex -kanji=utf8 %s"
                                     TeX-run-BibTeX nil t :help "Run pBibTeX"))
                      (add-to-list 'TeX-command-list
                                   '("upBibTeX" "upbibtex %s"
                                     TeX-run-BibTeX nil t :help "Run upBibTeX"))
                      (add-to-list 'TeX-command-list
                                   '("Mendex" "mendex -U %s"
                                     TeX-run-command nil t :help "Create index file with mendex"))
                      (add-to-list 'TeX-command-list
                                   '("TeXworks" "C:/w32tex/share/texworks/TeXworks %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run TeXworks"))
                      (add-to-list 'TeX-command-list
                                   '("SumatraPDF" "echo \"C:/Program Files/SumatraPDF/SumatraPDF\" -reuse-instance %o -forward-search \"%b\" %n | sed -e \"s/\\.dvi/\\.pdf/\" | cmd"
                                     TeX-run-discard-or-function t t :help "Forward search with SumatraPDF"))
                      (add-to-list 'TeX-command-list
                                   '("pdfopen" "tasklist /fi \"IMAGENAME eq AcroRd32.exe\" /nh | findstr \"AcroRd32.exe\" > nul && echo exit | pdfdde & pdfopen --file %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run Adobe Reader")))))



;;
;; RefTeX (AUCTeX)
;;
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)


;;
;; kinsoku.el
;;
(setq kinsoku-limit 10)







(provide 'setup.auctex)
;;--------------------------------------------------------------------------------------------------
;; EOF
