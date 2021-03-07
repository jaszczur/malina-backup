(in-package :malina-backup)

(defun run! (cmd &optional (args '()))
  (external-program:run cmd args :output t))

(defun do-backup ()
  (format t "Todo~%")
  (force-output)
  (run! "pwd")
  (run! "ls"))


#+nil
(progn

  (asdf:load-system :malina-backup)

  (do-backup)
  
  )
