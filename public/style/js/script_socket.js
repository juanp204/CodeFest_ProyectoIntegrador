import { io } from 'https://cdn.socket.io/4.3.2/socket.io.esm.min.js'

const socket = io()

const form = document.getElementById('form')
const input = document.getElementById('input')
const messages = document.getElementById('messages')

socket.on('chat message', (msg, serverOffset, username) => {
  const item = `<li>
    <p>${msg}</p>
    <small>${username}</small>
  </li>`
  messages.insertAdjacentHTML('beforeend', item)
  socket.auth.serverOffset = serverOffset
  // scroll to bottom of messages
  messages.scrollTop = messages.scrollHeight
})

form.addEventListener('submit', (e) => {
  e.preventDefault()

  if (input.value) {
    socket.emit('chat message', input.value)
    input.value = ''
  }
})