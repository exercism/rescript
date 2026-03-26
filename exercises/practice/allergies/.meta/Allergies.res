type allergen =
  | Cats
  | Pollen
  | Chocolate
  | Tomatoes
  | Strawberries
  | Shellfish
  | Peanuts
  | Eggs

let allergenToValue = (allergen: allergen): int => {
  switch allergen {
  | Eggs => 1
  | Peanuts => 2
  | Shellfish => 4
  | Strawberries => 8
  | Tomatoes => 16
  | Chocolate => 32
  | Pollen => 64
  | Cats => 128
  }
}

let allAllergens = [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]

let allergicTo = (allergen, score) => allergenToValue(allergen)->Int.bitwiseAnd(score) !== 0

let list = score => allAllergens->Array.filter(a => allergicTo(a, mod(score, 256)))
