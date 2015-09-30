;;;;; -*- Mode: Emacs-Lisp ; Coding: iso-2022-jp-dos -*-
;;
;; uenox-ps-print.el : Windows NT $BI8=`$N(B LPR $B$r;H$C$F(B ps-print $B$9$k(B
;; Copyright (C) 2000 UENO Tetsuyuki
;;
;; $BK\%W%m%0%i%`$O%U%j!<!&%=%U%H%&%'%"$G$9!#(B
;; $B!!$"$J$?$O!"(BFree Software Foundation$B$,8xI=$7$?(BGNU $B0lHL8xM-;HMQ5vBz$N(B
;;$B!V%P!<%8%g%s#2!W0?$$$O$=$l0J9_$N3F%P!<%8%g%s$NCf$+$i$$$:$l$+$rA*Br$7!"(B
;; $B$=$N%P!<%8%g%s$,Dj$a$k>r9`$K=>$C$FK\%W%m%0%i%`$r:FHRI[$^$?$OJQ99$9$k(B
;; $B$3$H$,$G$-$^$9!#(B
;; $B!!K\%W%m%0%i%`$OM-MQ$H$O;W$$$^$9$,!"HRI[$K$"$?$C$F$O!";T>l@-5Z$SFCDj(B
;; $BL\E*E,9g@-$K$D$$$F$N0EL[$NJ]>Z$r4^$a$F!"$$$+$J$kJ]>Z$b9T$J$$$^$;$s!#(B
;; $B>\:Y$K$D$$$F$O(BGNU $B0lHL8xM-;HMQ5vBz=q$r$*FI$_$/$@$5$$!#(B
;; $B!!(BGNU$B0lHL8xM-;HMQ5vBz$N<L$7$O(B http://www.gnu.org/copyleft/gpl.txt $B$+(B
;; $B$iF~<j$9$k$3$H$,$G$-$^$9!#(B
;; $B!!F|K\8lHG$K$D$$$F$O(B http://www.gnu.org/copyleft/ $B$r;2>H4j$$$^$9!#(B
;;
;; $BCx:n<T(B: $B>eLn(B $BE/9,(B "UENO Tetsuyuki" <uenox@livedoor.com>
;; $BHG>pJs(B: 0.02
;; $B:n@.F|;~!'(B2000/10/24
;; $BG[I[>l=j(B: http://uenox.hoops.livedoor.com/elisp/uenox-ps-print.el
;;
;;$B!ZF3F~![(B
;;  $B!!>e5-$NG[I[>l=j$+$i%U%!%$%k$r%@%&%s%m!<%I$7$F!"%[!<%`%G%#%l%/%H%j(B
;;  ("~")$B$K3JG<$7$F$/$@$5$$!#(B
;;
;;$B!Z@_Dj![(B
;;  $B=i4|2=%U%!%$%k(B .emacs $B$K0J2<$N9T$r=q$-2C$($F$/$@$5$$!#(B
;;    (setq load-path (cons "~" load-path))
;;    (load "uenox-ps-print")
;;
;;$B!!%G%U%)%k%H$N%W%j%s%?L>$H%W%j%s%?L>$N0lMw$rEPO?$r$9$k0Y!"0J2<$N9T$r(B
;;$B!!;29M$K=i4|2=%U%!%$%k(B .emacs $B$K=q$-2C$($F$/$@$5$$!#(B
;;    (setq uenox-ps-printer-name "pspr01")
;;    (setq uenox-ps-printer-name-list '("pspr01" 
;;                                       "pspr02"
;;                                       "pspr03"))
;;
;;$B!!(BM-x uenox-select-ps-printer $B$H$9$k$3$H$K$h$j!"EPO?$7$?%W%j%s%?$rA*(B
;;$B!!Br$9$k$3$H$,$G$-$k$h$&$K$J$j$^$9!#(B
;;
;;$B!Z@bL@![(B
;;  Windows NT $BI8=`$N(B lpr $B$r;H$C$F0u:~$9$k$3$H$,$G$-$k$h$&$K$J$j$^$9!#(B
;;
;;$B!Z(BTips$B![(B
;;  $B"(MQ;f%5%$%:$HMQ;fJ}8~$r@_Dj$9$k$K$O!"0J2<$N$h$&$K@_Dj$7$^$9!#(B
;;    (setq ps-paper-type 'a4) ; $B%5%$%:$OI,$:@_Dj$7$^$7$g$&!#(B
;;    (setq ps-landscape-mode t)
;;
;;  $B"(%Z!<%8$KJ#?tNs$N0u:~$r$9$k>l9g!"0J2<$N?tCM$r@_Dj$7$F$/$@$5$$!#(B
;;    (setq ps-number-of-columns 1)
;;
;;  $B"(%+%i!<0u:~BP1~(BPS$B%W%j%s%?!<$K0u:~$9$k$K$O0J2<$N$h$&$K$7$^$9!#(B
;;    (setq ps-print-color-p t)
;;
;;$B!ZCm0U![(B
;;  (1) $B$3$N%9%/%j%W%H$G$O(B uenox- $B$H$$$&J8;zNs$+$i;O$^$k%7%s%\%k$r;H$$(B
;;     $B$^$9!#(B
;;  (2) $B$3$N%9%/%j%W%H$G$O(B ps-print.el $B$N(B ps-print-region-function,  
;;     ps-printer-name, ps-multibyte-buffer $B$NFbMF$r=q$-49$($^$9!#(B
;;

;;; ps-printer $B$NL>>N(B
(defvar uenox-ps-printer-name nil
  "The name of a network PostScript Printer.")

;;; ps-printer $B$N%j%9%H(B
(defvar uenox-ps-printer-name-list nil
  "The list of network PostScript Printers.")

;;; ps-printer $B$rA*Br$9$k4X?t(B
(defun uenox-select-ps-printer()
  "Select PostScript Printer for output."
  (interactive)
  (setq uenox-ps-printer-name 
	(read-string "Select Printer : " 
		     uenox-ps-printer-name 
		     'uenox-ps-printer-name-list)))

;;; ps-print.el $B$,Ds6!$9$k4X?t(B ps-print-region-function $B$NBeBX4X?t(B
(defun uenox-ps-print-region-function(from to &rest arg)
  "For Windows NT LPR which cannot use pipe!"
  (let ((tmpfile 
	 (make-temp-name 
	  (concat 
	   (file-name-as-directory temporary-file-directory) "ps"))))
	(write-region from to tmpfile)
	(cd "~") ; for files on ftp-server.
	(if uenox-ps-printer-name
	    (shell-command (format "lpr -S %s -P %s -o l %s" 
				   uenox-ps-printer-name 
				   uenox-ps-printer-name 
				   tmpfile)))
	(delete-file tmpfile)))

;;; ps-print.el $B$,Ds6!$9$k4X?t$r>e5-$N4X?t$G6/@)E*$KCV$-49$($k!#(B
(setq ps-print-region-function 'uenox-ps-print-region-function)

;;; ps-printer.el $B$N%W%j%s%?L>$r(B($BG0$N0Y(B)$B6u$K$7$F$*$/!#(B
(setq ps-printer-name nil)

;;; ps-printer.el $B$N@_Dj$rJQ99$7!"%^%k%A%P%$%H$N0u:~$r2DG=$K$9$k!#(B
(setq ps-multibyte-buffer 'non-latin-printer)
