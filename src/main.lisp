(in-package :malina-backup.main)

(defun start (args)
  (let ((iot-stack-dir (uiop:ensure-directory-pathname (pathname (first args))))
        (backups-dir (uiop:ensure-directory-pathname (pathname (second args)))))
    (do-backup iot-stack-dir backups-dir)))

(defun main ()
  (start (uiop:command-line-arguments)))

#+nil
(progn
  (asdf:make :malina-backup/executable)

  (start '( "/tmp/IOTStack"  "/tmp/iots-bak"))
  
  )
