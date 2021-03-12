(in-package :malina-backup)

(defun log-info (msg &rest args)
  (apply #'format (append (list t msg) args))
  (format t "~%")
  (force-output))

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
    (log-info "Performing backup of ~a to ~a.~%" iot-stack-dir bkp-archive)

    (unwind-protect
         (progn
           (log-info "Stopping services...")
           (run! '("docker-compose" "down") :cwd iot-stack-dir)
           (mkdir target-dir)
           (log-info "Creating archive...")
           (run! (list "tar" "zcvf" (namestring bkp-archive) (namestring iot-stack-dir))))
      (log-info "Starting services...")
      (run! '("docker-compose" "up" "-d") :cwd iot-stack-dir))))

#+nil
(progn
  (asdf:load-system :malina-backup)
  (do-backup (pathname "/tmp/IOTStack/")  (pathname "/tmp/iots-bak/"))

  )
