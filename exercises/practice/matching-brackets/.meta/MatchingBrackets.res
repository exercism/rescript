let isPaired = s => {
  let rec aux = (chars, stack) =>
    switch (chars, stack) {
    | (list{}, list{}) => true
    | (list{}, _) => false
    | (list{"(", ...rest}, _) => aux(rest, list{")", ...stack})
    | (list{"{", ...rest}, _) => aux(rest, list{"}", ...stack})
    | (list{"[", ...rest}, _) => aux(rest, list{"]", ...stack})
    | (list{")", ...rest}, list{")", ...tail})
    | (list{"}", ...rest}, list{"}", ...tail})
    | (list{"]", ...rest}, list{"]", ...tail}) =>
      aux(rest, tail)
    | (list{")" | "}" | "]", ..._}, _) => false
    | (list{_, ...rest}, _) => aux(rest, stack)
    }
  aux(s->String.split("")->List.fromArray, list{})
}
