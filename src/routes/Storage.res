let key = "token"

let getToken = () => Dom.Storage2.getItem(Dom.Storage2.sessionStorage, key)

let setToken = token => Dom.Storage2.setItem(Dom.Storage2.sessionStorage, key, token)

let deleteToken = () => Dom.Storage2.removeItem(Dom.Storage2.sessionStorage, key)
