(asdf:defsystem :malina-backup
  :description "Backup my RaspberryPi files"
  :author "Piotr Jaszczyk <piotr.jaszczyk@gmail.com>"

  :license "MIT"
  :version "0.0.1"

  :depends-on ("uiop" "alexandria" "local-time")

  :in-order-to ((asdf:test-op (asdf:test-op :malina-backup/test)))

  :serial t
  :components ((:file "package")
               (:module "src"
                :serial t
                :components ((:file "core")))))

(asdf:defsystem :malina-backup/executable
  :build-operation program-op
  :build-pathname "malina-backup"
  :entry-point "malina-backup.main:main"
  :depends-on ("malina-backup" "uiop")
  :serial t
  :components ((:file "package.exec")
               (:module "src"
                :serial t
                :components ((:file "main")))))


(asdf:defsystem :malina-backup/test
  :description "Test suite for malina-backup"

  :author "Piotr Jaszczyk <piotr.jaszczyk@gmail.com>"
  :license "MIT"

  :depends-on ("malina-backup" "1am")

  :serial t
  :components ((:file "package.test")
               (:module "test"
                :serial t
                :components ((:file "tests"))))
  :perform (asdf:test-op (op system)
                         (funcall (read-from-string "malina-backup.test:run-tests"))))

