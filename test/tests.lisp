(in-package :malina-backup.test)

(defmacro define-test (name &body body)
  `(test ,(intern (concatenate 'string (symbol-name 'test-) (symbol-name name)))
     ,@body))

(defun run-tests ()
  (1am:run))

;; (define-test format-prices-lines
;;   (is (string=
;;        "P 2021-01-24 20:26:00 \"BETAM40TR\" 58.0 \"PLN\"
;; P 2021-01-24 20:26:00 \"CDPROJEKT\" 250.1 \"PLN\"
;; P 2021-01-24 20:26:00 \"DECORA\" 30.0 \"PLN\""
;;        (malina-backup:format-prices-lines *sample-prices*)))

;;   (is (string= "" (malina-backup:format-prices-lines '()))))

#+nil
(progn
  (run-tests)
  (setf *tests* nil)
  )
