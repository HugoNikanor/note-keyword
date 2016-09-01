(ns sql-wrapper.macros)

(defn fallback
  "tries a value, and if that evaluates to an equivalent to false then
  the fallback value is used instead"
  [init fall]
  (let [i init]
    (if i i fall)))

(defn best-key
  "Try to access keywords from a hash map until a key which works is found"
  [data & keys]
  (if (empty? keys)
     false
     (fallback
       (data (first keys))
       (apply best-key (cons data (rest keys))))))
