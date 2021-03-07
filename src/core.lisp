(in-package :malina-backup)

(defmacro with-cwd (dir &body body)
  (with-gensyms (original-directory)
    `(if ,dir
         (let ((,original-directory (uiop:getcwd)))
           (unwind-protect (progn
                             (uiop:chdir ,dir)
			                       ,@body)
	           (uiop:chdir ,original-directory)))
         ,@body)))

(defun run! (cmd &key cwd)
  (with-cwd cwd
    (uiop:run-program cmd :output :lines)))

(defun timestamp ()
  (local-time:format-timestring nil (local-time:now)))

(defun backup-file (root)
  (merge-pathnames root (pathname (format nil "~a.tar.gz" (timestamp)))))

(defun mkdir (dir)
  (ensure-directories-exist dir))

(defun do-backup (iot-stack-dir target-dir)
  (let ((bkp-archive (backup-file target-dir)))
    (format t "Performing backup of ~a to ~a.~%" iot-stack-dir bkp-archive)
    (force-output)
    (mkdir target-dir)
    (run! (list "tar" "zcvf" (namestring bkp-archive) (namestring iot-stack-dir)))))

#+nil
(progn
  (asdf:load-system :malina-backup)
  (do-backup (pathname "/tmp/IOTStack/")  (pathname "/tmp/iots-bak/"))
  )
