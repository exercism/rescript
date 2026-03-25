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

let allergicTo = (allergen, score) => {
  let target = allergenToValue(allergen)
  Int.bitwiseAnd(score, target) !== 0
}

let list = score => {
  let effectiveScore = mod(score, 256)
  let filteredAllergens = allAllergens->Array.filter(a => allergicTo(a, effectiveScore))
  if Array.length(filteredAllergens) === 0 {
    None
  } else {
    Some(filteredAllergens)
  }
}
