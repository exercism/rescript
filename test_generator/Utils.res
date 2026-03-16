let getTestCaseInput = (case: GetCases.case, inputName: string) => {
  case.input->JSON.Decode.object->Option.getOrThrow->Dict.get(inputName)->Option.getOrThrow
}
