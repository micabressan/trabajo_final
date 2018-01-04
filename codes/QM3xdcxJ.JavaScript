function getHTMLBodyFromURL(url) {
  return fetch('https://github.com/')
}

getHTMLBodyFromURL(url).then(function(response) {
  console.log(response) // Log is undefined
})