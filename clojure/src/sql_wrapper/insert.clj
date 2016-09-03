(ns sql-wrapper.insert
  (:require [clojure.java.jdbc :as sql]
            [sql-wrapper.macros :refer :all]))

(defn add-course!
 "Adds a course to the database, returns the mysql id of the course,
 both if it already existed and if it didn't"
 [database name]
  (best-key
    (first (try
             (sql/insert! database
                          :courses
                          {:name name})
             (catch Exception e
               (sql/query database ["select id from courses where name like ?" name]))))
    :generated_key :id))

(defn add-note!
  "Adds information that a note exists to the database, the note
  should be named  the same with the date, and the name field is
  simply if a second simple identification is available.

  The function returns the mysql id of the note,
  both if it exists since before and not"
  [database date course_id & [name]]
  (best-key
    (first (try
             (sql/insert! database
                          :notes
                          (merge {:date date
                                  :course_id course_id}
                                 (if name {:name name})))
             (catch Exception e
               (sql/query database ["select id from notes"]))))
    :generated_key :id))

(defn add-keyword-defs!
 "Tell the database that the following words should be able to be used
 as keywords. Inserts the names not already presents, and returns a
 list of the id's of the keywords"
 [database & name]
  (let [id (System/currentTimeMillis)]
    (sql/execute! database
                  (into []
                        (cons
                          (str "insert into keywords (name, group_id)
                               values "
                               (clojure.string/join ", "
                                                    (repeat (count name) "(?, ?)"))
                               " on duplicate key update group_id = ?")
                          (concat
                            (apply concat (map #(list %1 id) name))
                            [id]))))
    (map #(%1 :id)
         (sql/query database ["select id from keywords where group_id = ?"
                         id]))))

(defn add-keyword-bindings!
 "Adds bindings in the database between a note and a number of
 keywords. failsafe if stuff already exists. Undefined return value"
 [database note_id & keyword_ids]
    (sql/execute! database
                  (into []
                        (cons
                          (str "insert ignore into keyword_bindings (note_id, keyword_id)
                               values "
                               (clojure.string/join ", "
                                       (repeat (count keyword_ids) "(?, ?)")))
                          (apply concat (map #(list note_id %1) keyword_ids))))))

(defn add-keywords-main!
  "Inserts a number of keyword bindings and required metadata for the
  keywords into the database. All fields except keywords should be a
  single value, and keywords a list of strings to be inserted. Note
  that all arguments need to be filled.

  Return undefined.

  TODO the argument list should possibly be changed from taking keys
  to just being raw, to force the user to give complete data."
  [& {:keys [database course date document_name keywords]}]
  (let [course_id (add-course! database course)
        note_id (add-note! database date course_id (if document_name document_name))
        keyword_ids (apply add-keyword-defs! (cons database keywords))]
    (apply add-keyword-bindings! (cons database (cons note_id keyword_ids)))))
