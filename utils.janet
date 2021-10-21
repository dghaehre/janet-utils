(import sh)

(defn key_by_value [strct value]
  "Get key from table/struct by value"
  (var chosen-key nil)
  (loop [[key val] :in (pairs strct)] 
    (if (= value val)
      (set chosen-key key)))
  chosen-key)

(defn fzf [alternatives prmpt]
  ```
  Simple fzf wrapper

  Takes a struct with key and values and returns the key that is chosen
  ```
  (var chosen-key :error)
  (def setups (reduce2 (fn [a b] (string a "\n" b)) (values alternatives)))
  (def chosen-value (sh/$< echo -e ,setups | fzf --prompt ,prmpt))
  (key_by_value alternatives (string/trim chosen-value)))
