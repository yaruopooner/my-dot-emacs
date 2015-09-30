;;; -*- Mode: Emacs-Lisp ; Coding: iso-2022-jp-dos -*-
;;
;; uenox-dired.el : Dired $B%b!<%I$r3HD%$9$k(B Emacs Lisp $B%9%/%j%W%H(B
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
;; $B!!$"$J$?$O!"K\%W%m%0%i%`$H0l=o$K(BGNU$B0lHL8xM-;HMQ5vBz$N<L$7$r<u$1<h$C$F(B
;; $B$$$k$O$:$G$9!#$=$&$G$J$$>l9g$O!"(B
;;   Free Software Foundation, Inc.,
;;   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA 
;; $B$X<j;f$r=q$$$F$/$@$5$$!#(B
;;
;; $BCx:n<T(B: $B>eLn(B $BE/9,(B "UENO Tetsuyuki" <uenox@livedoor.com>
;; $BHG>pJs(B: 1.00
;; $B:n@.F|;~!'(B2000/10/21
;; $BG[I[>l=j(B: http://uenox.hoops.livedoor.com/elisp/uenox-dired.el
;;
;;
;;$B!ZF3F~![(B
;;  $B>e5-$NG[I[>l=j$+$i%U%!%$%k$r%@%&%s%m!<%I$7$F!"%[!<%`%G%#%l%/%H%j(B("~")
;;  $B$K3JG<$7$F$/$@$5$$!#(B
;;
;;$B!Z@_Dj![(B
;;  $B=i4|2=%U%!%$%k(B .emacs $B$K0J2<$N9T$r=q$-2C$($F$/$@$5$$!#(B
;;    (setq load-path (cons "~" load-path))
;;    (load "uenox-dired")
;;
;;$B!Z@bL@![(B
;;  Dired $B$K0J2<$N(B3$B$D$N5!G=$,DI2C$5$l$^$9!#!J%-!<%^%C%W$O$3$N%U%!%$%k$N(B
;;  $B:G8e$NJ}$r=q$-49$($k$3$H$GJQ99$G$-$^$9!#!K(B
;;   * C-j 
;;     $B8=:_$N9T$N%U%!%$%k$r(BWindows$B$K4XO"IU$1$i$l$?%"%W%j%1!<%7%g%s$r;H$C(B
;;     $B$F3+$-$^$9!#!J$o$6$o$6%(%/%9%W%m!<%i!<$r3+$+$J$/$FNI$/$J$j$^$9!#!K(B
;;   * w
;;     $B8=:_$N9T$N%U%!%$%kL>$r(BUNIX$B7A<0$K$F%3%T!<$7$^$9!#(B
;;   * W
;;     $B8=:_$N9T$N%U%!%$%kL>$r(BDOS$B7A<0$K$F%3%T!<$7$^$9!#(B
;;
;;$B!Z(BTips$B![(B
;;  $B!!%U%!%$%k$rJL$N%G%#%l%/%H%j$K%3%T!<$7$?$$$H$-$K!"$^$:%3%T!<@h$N%G%#(B
;;$B!!%l%/%H%j$r(BDired$B$G3+$$$F!H(B.$B!I$NItJ,$K%+!<%=%k$r;}$C$F$$$F(B w $B$r2!$7$^(B
;;$B!!$9!#<!$K!"%3%T!<$7$?$$%U%!%$%k$,3JG<$5$l$F$$$k%G%#%l%/%H%j$G%U%!%$%k(B
;;$B!!$N0LCV$K%+!<%=%k$r;}$C$F$$$F(B C $B$r2!$7$^$9!#%_%K%P%C%U%!$,3+$/$N$G!"(B
;;$B!!(BC-y $B$H$7$F%3%T!<@h$N%G%#%l%/%H%jL>$r%d%s%/$7$?8e(B Enter $B$r2!$7$^$9!#(B
;;
;;$B!ZCm0U![(B
;;  (1) $B$3$N%9%/%j%W%H$NCf$G$O(B uenox-dired- $B$H$$$&J8;zNs$+$i;O$^$k%7%s%\(B
;;    $B%k$r;H$C$F$$$^$9!#(B
;;  (2) Windows98$B$GHs(BASCII$BJ8;zNs$r;H$C$?%m%0%$%sL>$G%m%0%$%s$7$?>l9g$K$b!"(B
;;    $B%U%!%$%k$N=jM-<T$,@5>o$KI=<($5$l$k$h$&$K$9$k$?$a!"(Buser-login-name$B$H(B
;;    user-real-login-name$B$r(Bsjis$B$G(Bdecode$B$7$F$$$^$9!#(B
;;

;;; Dired $B$G(B Windows $B$K4XO"IU$1$i$l$?%U%!%$%k$r5/F0$9$k!#(B
(defun uenox-dired-winstart()
  "Type '\\[uenox-dired-winstart]': win-start the current line's file."
  (interactive)
  (if (eq major-mode 'dired-mode)
      (let ((fname (dired-get-filename)))
	(w32-shell-execute "open" fname)
	(message "win-started %s" fname)
      )
    )
  )

;;; Dired $B$G(B UNIX $B7A<0$G%U%!%$%kL>$r%3%T!<$9$k!#(B
(defun uenox-dired-kill-filename-unix()
  "Type '\\[uenox-dired-kill-filename-unix]': copy the current line's filename(unix)."
  (interactive)
  (if (eq major-mode 'dired-mode)
      (let ((fname (dired-get-filename))) 
	(kill-new fname)
	(message "%s" fname)
	)
    )
  )

;;; Dired $B$G(B DOS $B7A<0$G%U%!%$%kL>$r%3%T!<$9$k!#(B
(defun uenox-dired-kill-filename-dos()
  "Type '\\[uenox-dired-kill-filename-dos]': copy the current line's filename(dos)."
  (interactive)
  (if (eq major-mode 'dired-mode)
      (let ((fname (unix-to-dos-filename (dired-get-filename))))
	(kill-new fname)
	(message "%s" fname)
	)
    )
  )

;;; Dired $B$N5/F0;~$K%-!<%\!<%I%^%C%W$r=q$-49$($k!#(B
(add-hook 'dired-mode-hook
	  '(lambda ()
	     (define-key dired-mode-map "\C-j" 'uenox-dired-winstart)
	     (define-key dired-mode-map "w" 'uenox-dired-kill-filename-unix)
	     (define-key dired-mode-map "W" 'uenox-dired-kill-filename-dos)
	     )
	  )

;;; $BHs(BASCII$BJ8;zNs$G%m%0%$%s$7$F$b(B Dired $B$G@5>o$KI=<($5$l$k$h$&$K$7$^$9!#(B
(setq user-login-name (decode-coding-string user-login-name 'sjis))
(setq user-real-login-name (decode-coding-string user-real-login-name 'sjis))
