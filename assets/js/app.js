import "phoenix_html"
import socket from "./socket"
import React, {Component} from "react"
import {render} from "react-dom"
import Garden from "./Garden"

let el = document.getElementById("garden")

if (window.userToken) {
  socket.connect()
}

if (el) {
  render(<Garden socket={socket} gardenId={el.dataset.gardenId} />, el)
}
