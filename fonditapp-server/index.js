const WebSocket = require ('ws');

const server = new WebSocket.Server({ port: 3000 });

server.on('connection', (socket) => {
    console.log("Someone connected")
    socket.on('message', (data) => {
        console.log(data);
        server.clients.forEach(client => {
            client.send(data)
        });
    })
})