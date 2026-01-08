(defun tasks-new-huid ()
  (format-time-string "%Y%m%d-%H%M%S"))

(defun traverse-from-current-driectory ()
  (let ((dir default-directory))
    (while dir
      (message "%s" dir)
      (setq dir (file-name-parent-directory dir)))))

(defun tasks-find-database0 ()
  (let ((dir default-directory)
        (result nil))
    (while (and dir (not result))
      (let ((task-dir (file-name-concat dir "task")))
        (if (file-directory-p task-dir)
            (setq result task-dir)
          (setq dir (file-name-parent-directory dir)))
        )
      ) result
    )
  )

(defun task-find-database ()
  (let ((dir default-directory))
    (catch 'result
      (while dir
        (let ((db-dir (file-name-concat dir "tasks")))
          (if (file-directory-p db-dir)
              (throw 'result db-dir)
            (setq dir (file-name-parent-directory dir))))))))

(tasks-find-database)

(defun tasks-create-from-todo0 ()
  (let ((line (thing-at-point 'line)))
    (when (string-match "\\(.*\\)TODO:\\(.*\\)" line)
      (message "PREFIX: %s" (match-string 1 line))
      (message "SUFFIX: %s" (match-string 2 line))))
  )

(defun tasks-create-from-todo1 ()
  (interactive)
  (let ((line (thing-at-point 'line)))
    (when (string-match "\\(.*\\)TODO:\\(.*\\)" line)
      (let ((prefix (match-string 1 line))
            (suffix (match-string 2 line)))
        (delete-line)
        (insert (format "%sTASK(%s):%s\n" prefix (tasks-new-huid) suffix)))
      )
    )
  )

