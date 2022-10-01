(defn key-by
  ```
  Get key from table/struct by a predicate that takes
  two arguments [key value] and return a boolean.
  Return nil if not found.
  ```
  [pred strct]
  (var chosen-key nil)
  (loop [[key val] :in (pairs strct)] 
    (if (pred key val)
      (set chosen-key key)))
  chosen-key)

(defn key-by-value
  ```
  Get key from table/struct by matching on given value.
  Return nil if not found.
  ```
  [strct value]
  (key-by |(= $1 value) strct))

(defn fish
  ```
  Run command as fish shell
  ```
  [s]
  (os/execute @("/usr/bin/fish" "-c" s) :e))

(defmacro with-exit
  "Exit if there was an error"
  [& body]
  ~(try ,body ([_] (os/exit 0))))

(defmacro no-err
  "Error is fine"
  [& body]
  ~(try ,body ([_] ())))

(defmacro with-err
  "Map possible error"
  [err & body]
  ~(try ,;body ([_] (error ,err))))

(defn elem
  "Check in elem exist in array"
  [arr pred]
  (var exist false)
  (each e arr
    (if (pred e)
      (set exist true)))
  exist)

(defn end
  `Take last element of list`
  [arr &opt none]
  (get arr (- (length arr) 1) none))

(defn tail
  `Return list without head`
  [arr]
  (array/slice arr 1 (length arr)))

(defn map-indexed
  ```
  A map that also provide an index
  (map-indexed (fn [i v] [i v] ) ["a" "b" "c" "d"])
  ```
  [f ds]
  (map f (range 0 (length ds)) ds))

(defmacro flip
  ```
  Flip argument for the given function.
  Last argument becomes the first.
  Second argument becomes second.
  Third becomes third etc.

  (flip map [1 2 3] (fn [i] (+ 1 i)))
  ```
  [f & args]
  ~(,f ,(end args) ,;(drop 1 (reverse args))))
