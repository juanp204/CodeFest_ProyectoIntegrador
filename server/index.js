import express from 'express'
import logger from 'morgan'

import { Server } from 'socket.io'
import { createServer } from 'node:http'

const port = process.env.PORT ?? 3000

const app = express()
const server = createServer(app)
const io = new Server(server, {
    connectionStateRecovery: {}
})

io.on('connection', (socket) => {
    console.log('Un usuario se ha conectado')

    socket.on('disconnect', () => {
        console.log('Un usuario se ha desconectado')
    })

    socket.on('chat message', (msg) => {
        io.emit('chat message', msg)
    })
})


app.use(logger('dev'))

app.use(express.static('public'));

app.get('/', (req, res) => {
    res.sendFile(process.cwd() + '/client/index.html')
})

server.listen(port, () => {
    console.log('Server running on port ' + port)
})