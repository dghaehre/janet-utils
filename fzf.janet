(import sh)
(use ./utils)

(defn fzf [alternatives prmpt]
  ```
  Simple fzf wrapper

  Takes a struct with key and values and returns the key that is chosen.
  The values will be shown to the user.
  ```
  (var chosen-key :error)
  (def setups (reduce2 (fn [a b] (string a "\n" b)) (values alternatives)))
  (def chosen-value (sh/$< echo -e ,setups | fzf --prompt ,prmpt))
  (key-by-value alternatives (string/trim chosen-value)))

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
