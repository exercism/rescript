let primes = limit => {
  let flags = Array.fromInitializer(~length=limit + 1, _ => true)
  flags->Array.set(0, false)
  flags->Array.set(1, false)

  for i in 2 to limit->Float.fromInt->Math.sqrt->Int.fromFloat {
    if flags->Array.getUnsafe(i) {
      let j = ref(i * i)
      while j.contents <= limit {
        flags->Array.set(j.contents, false)
        j := j.contents + i
      }
    }
  }

  flags
  ->Array.mapWithIndex((isPrime, i) => (isPrime, i))
  ->Array.filter(((isPrime, _)) => isPrime)
  ->Array.map(((_, i)) => i)
}
