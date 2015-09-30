;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2013/01/24.21:00:59


;;==================================================================================================
;; cedet setup
;;==================================================================================================


;; load path addition
(add-to-list 'load-path (expand-file-name "emacs-wiki/" de:path-plugins))



;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


;; (load-library "emacs-wiki")
(require 'emacs-wiki)


;; (require 'planner)
;; (require 'latex-markup)
;; (require 'texinfo-markup)




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        Utility Function                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun emacs-wiki-get-modtime (file)
  (format-time-string " %Y/%m/%d %h:%M:%S " (nth 4 (file-attributes file))))

(defun emacs-wiki-get-filesize (file)
  (format "<center> %d </center>" (nth 7 (file-attributes file))))

(defun emacs-wiki-generate-index (&optional as-list exclude-private)
  "インデックスページの作成関数"
  (let ((project emacs-wiki-current-project))
    (with-current-buffer (get-buffer-create "*Wiki Index*")
      (erase-buffer)
      (if project
          (emacs-wiki-change-project project))
      (let ((files (sort (copy-alist (emacs-wiki-file-alist))
                         (function
                          (lambda (l r)
                            (string-lessp (emacs-wiki-get-modtime (car r))
                                          (emacs-wiki-get-modtime (car l)))))))
            file)
        (insert "<div id=\"recent\"><center>\n")
        (let ((num 0))
          (insert "順位 | <center>ファイル名</center> | ファイルサイズ | <center> 更新日時 </center>\n")
          (insert "\n<nop>\n")
          (while files
            (unless (and exclude-private
                         (emacs-wiki-private-p (caar files)))
              (incf num)
              (insert (if as-list " " "") 
                      (format "<center>%d</center>" num)
                      " | "
                      "<center>[[" (caar files) "]]</center>"
                      " | "
                      (emacs-wiki-get-filesize (caar files))
                      " | "
                      (emacs-wiki-get-modtime (caar files))
                      "\n"))
            (setq files (cdr files))))
        (insert "\n</center></div>\n"))
      (current-buffer))))

;;; emacs-wiki-publishing-{header, footer} 用
(defun emacs-wiki-project-insert-header (project)
  "project 名を prefix とした header を挿入"
  (emacs-wiki-project-insert-templete (symbol-name project) "-header"))

(defun emacs-wiki-project-insert-footer (project)
  "project 名を prefix とした footer を挿入"
  (emacs-wiki-project-insert-templete (symbol-name project) "-footer"))

(defun emacs-wiki-project-insert-templete (project templete)
  "project 名 + テンプレート名 のファイル内容を挿入"
  (let ((file (concat "~/Wiki/wiki/" project templete)))
    (when (file-readable-p file)
      (ignore (insert-file-contents file)))))

;;; <lisp> ... </lisp> 用
(defun emacs-wiki-figure-with-class (class url width height caption)
  "caption 付きの図を挿入する関数 (クラス指定付き)"
  (format (concat "<nowiki><div class=\"%s\"><a href=\"%s\">"
                  "<img width=\"%s\" height=\"%s\" src=\"%s\" /></a>\n"
                  "<p class=\"caption\">%s</p></div></nowiki>")
          class url width height url caption))

(defun emacs-wiki-figure (url width height caption)
  "caption 付きの図を挿入"
  (emacs-wiki-figure-with-class "fig" url width height caption))

(defun emacs-wiki-figure-right (url width height caption)
  "caption 付きの図を挿入 (float: right)"
  (emacs-wiki-figure-with-class "figright" url width height caption))

(defun emacs-wiki-figure-left (url width height caption)
  "caption 付きの図を挿入 (float: left)"
  (emacs-wiki-figure-with-class "figleft" url width height caption))

(defun emacs-wiki-insert-source-code (lang file) 
  "file の内容を example タグでかこったものに展開される"
  (when (file-exists-p file)
    (with-temp-buffer
      (if (and (executable-find "nkf") (executable-find "code2html"))
          (progn
            (eshell-command (concat "nkf -e " file " |code2html -l " (symbol-name lang) " -o html-light -H >>> "
                                    (prin1-to-string (current-buffer))))
            (concat "<no" "wiki><pre>" (buffer-string) "</pre></no" "wiki>"))
        (insert-file file)
        (concat "<" "example" ">" (buffer-string) "<" "/" "example>")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        Configuration                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key [f5] #'emacs-wiki-find-file)

                                        ;(define-key emacs-wiki-mode-map (kbd "C-c C-m") '(lambda ()
(define-key emacs-wiki-mode-map (kbd "C-j") '(lambda ()
                                               (interactive)
                                               (insert-string "<br>\n")))

(setq emacs-wiki-directories  '("~/Wiki/geo/"))
(setq emacs-wiki-publishing-directory "~/public_html/wiki/")
(setq emacs-wiki-inline-images t)
(setq emacs-wiki-publishing-transforms '(("WelcomePage" . "index")))
(setq emacs-wiki-meta-content-coding "euc-jp")
                                        ;(setq emacs-wiki-meta-content-coding "sjis")

(setq emacs-wiki-default-page "index")
(setq emacs-wiki-home-page "index")
(setq emacs-wiki-index-page "wiki_index")
(setq emacs-wiki-charset-default "euc-jp")
                                        ;(setq emacs-wiki-charset-default "sjis")
(setq emacs-wiki-coding-default "euc-jp")
                                        ;(setq emacs-wiki-coding-default "sjis")
(setq emacs-wiki-maintainer nil)

(setq emacs-wiki-style-sheet
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"default.css\">")
(setq emacs-wiki-publishing-header
      "<?xml version=\"1.0\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"
    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\">
  <head>
    <title><lisp>(emacs-wiki-page-title)</lisp></title>
    <meta name=\"generator\" content=\"emacs-wiki.el\" />
    <meta http-equiv=\"<lisp>emacs-wiki-meta-http-equiv</lisp>\"
          content=\"<lisp>emacs-wiki-meta-content</lisp>\" />
    <link rel=\"home\" href=\"<lisp>(emacs-wiki-published-name
                                     emacs-wiki-home-page)</lisp>\" />
    <link rel=\"index\" href=\"<lisp>(emacs-wiki-published-name
                                      emacs-wiki-index-page)</lisp>\" />
    <lisp>emacs-wiki-style-sheet</lisp>
  </head>
  <body>

    <!-- If you want a menu, uncomment the following lines and
    put (require 'emacs-wiki-menu) in your Emacs setup somewhere.

    <lisp>(when (boundp 'emacs-wiki-menu-factory)
            (funcall emacs-wiki-menu-factory))</lisp>
    -->

    <h1 id=\"top\"><lisp>(emacs-wiki-page-title)</lisp></h1>

    <!-- Page published by Emacs Wiki begins here -->\n")
(setq emacs-wiki-publishing-footer
      "
    <!-- Page published by Emacs Wiki ends here -->
    <div class=\"navfoot\">
      <hr />
      <table width=\"100%\" border=\"0\" summary=\"Footer navigation\">
        <col width=\"33%\" /><col width=\"34%\" /><col width=\"33%\" />
        <tr>
          <td align=\"left\">
            <lisp>
              (if buffer-file-name
                  (concat
                   \"<span class=\\\"footdate\\\">Last Modified: \"
                   (format-time-string emacs-wiki-footer-date-format
                    (nth 5 (file-attributes buffer-file-name)))
                   (and emacs-wiki-serving-p
                        (emacs-wiki-editable-p (emacs-wiki-page-name))
                        (concat
                         \" / \"
                         (emacs-wiki-link-href
                          (concat \"editwiki?\" (emacs-wiki-page-name))
                          \"Edit\")))
                   \"</span>\"))
            </lisp>
          </td>
          <td align=\"center\">
          </td>
          <td align=\"right\">
            <span class=\"foothome\">
              <lisp>
                (concat
                 (and (emacs-wiki-page-file emacs-wiki-home-page t)
                      (not (emacs-wiki-private-p emacs-wiki-home-page))
                      (concat
                       (emacs-wiki-link-href emacs-wiki-home-page \"Home\")
                       \" / \"))
                 (emacs-wiki-link-href emacs-wiki-index-page \"WikiIndex\")
                 (and (emacs-wiki-page-file \"ChangeLog\" t)
                      (not (emacs-wiki-private-p \"ChangeLog\"))
                      (concat
                       \" / \"
                       (emacs-wiki-link-href \"ChangeLog\" \"Changes\"))))
              </lisp>
            </span>
          </td>
        </tr>
      </table>
    </div>
  </body>
</html>\n")





(provide 'setup.emacs-wiki)
;;--------------------------------------------------------------------------------------------------
;; EOF
