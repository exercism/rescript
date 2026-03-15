type point = {x: float, y: float, angle: float}
type prism = {id: int, point: point}

let findSequence = (start: point, prisms: array<prism>): array<int> => {
  let sequence = []
  let x = ref(start.x)
  let y = ref(start.y)
  let angle = ref(start.angle)
  let active = ref(true)

  while active.contents {
    let dir = angle.contents *. Math.Constants.pi /. 180.0
    let cosDir = Math.cos(dir)
    let sinDir = Math.sin(dir)

    let nearest = prisms
      ->Array.filterMap(prism => {
        let dx = prism.point.x -. x.contents
        let dy = prism.point.y -. y.contents
        let distAlongRay = dx *. cosDir +. dy *. sinDir
        let perpOffset = dx *. sinDir -. dy *. cosDir
        distAlongRay > 0.0 && Math.abs(perpOffset) < 1e-3 *. Math.hypot(dx, dy)
          ? Some((distAlongRay, prism))
          : None
      })
      ->Array.reduce(None, (closestSoFar, (distAlongRay, prism)) =>
        switch closestSoFar {
        | Some((closestDist, _)) if closestDist < distAlongRay => closestSoFar
        | _ => Some((distAlongRay, prism))
        }
      )

    switch nearest {
    | None => active := false
    | Some((_, prism)) =>
      sequence->Array.push(prism.id)
      x := prism.point.x
      y := prism.point.y
      angle := angle.contents +. prism.point.angle
    }
  }

  sequence
}
