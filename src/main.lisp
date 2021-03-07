(in-package :malina-backup.main)

(defun start (args)
  (do-backup))

(defun main ()
  (start (uiop:command-line-arguments)))

#+nil
(progn
  (asdf:make :ledger-asset-prices/executable)

  (start '("2021-02-25"))
  
  )
