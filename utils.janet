(import sh)



(defn key_by [pred strct]
  ```
  Get key from table/struct by a predicate that takes
  two arguments [key value] and return a boolean.
  Return nil if not found.
  ```
  (var chosen-key nil)
  (loop [[key val] :in (pairs strct)] 
    (if (pred key val)
      (set chosen-key key)))
  chosen-key)



(defn key_by_value [strct value]
  ```
  Get key from table/struct by matching on given value.
  Return nil if not found.
  ```
  (key_by (fn [_ val] (= val value)) strct))




(defn fzf [alternatives prmpt]
  ```
  Simple fzf wrapper

  Takes a struct with key and values and returns the key that is chosen.
  The values will be shown to the user.
  ```
  (var chosen-key :error)
  (def setups (reduce2 (fn [a b] (string a "\n" b)) (values alternatives)))
  (def chosen-value (sh/$< echo -e ,setups | fzf --prompt ,prmpt))
  (key_by_value alternatives (string/trim chosen-value)))



(defn fzfn [prmpt alternatives]
  ```
  fzf wrapper

  Does not return anything, but runs the corresponding function.

  alternatives example:
  {"one"   '(print "one")
   "two"   '(print "something else")}

  Takes a struct with key and values and returns the key that is chosen.
  The values will be shown to the user.
  ```
  (def setups
    # Uses the _key_ in the struct to show to the user as an option
    (->> (keys alternatives)
         (reduce2 |(string $0 "\n" $1))))

  (def chosen-value
    (->> (sh/$< echo -e ,setups | fzf --prompt ,prmpt)
         (string/trim)))

  (eval (get alternatives chosen-value)))



(defn fish [s]
  ```
  Run command as fish shell
  ```
  (os/execute @("/usr/bin/fish" "-c" s) :e))
