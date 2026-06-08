let clean = phrase => {
  let cleanNoDigits = input => String.replaceRegExp(input, /\D/g, "")

  let checkFormat = phone => {
    let re = /^1?[2-9]\d{2}[2-9]\d{2}\d{4}$/
    RegExp.test(re, phone) ? Some(String.slice(~start=-10, phone)) : None
  }

  phrase->cleanNoDigits->checkFormat
}
