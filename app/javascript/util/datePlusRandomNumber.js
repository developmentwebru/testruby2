function datePlusRandomNumber() {
  return new Date().getTime() + Math.floor(Math.random() * 100000)
}

export default datePlusRandomNumber
