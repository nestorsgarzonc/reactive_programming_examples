import express from "express";
import cors from 'cors';
import { Server } from "socket.io";
import { createServer } from "http";

const app = express();
const server = createServer(app);
const io = new Server(server)

app.use(express.json());

app.use(cors({
    "origin": "*",
    "methods": "*",
}));

app.get("/", (_, res) => {
    res.send("Hi classmates!");
});

io.on("connection", (socket) => {
    console.log("a user connected");
    socket.on('chat:message', (msg) => socket.emit('chat:message', msg));
    socket.on('chat:join', (msg) => socket.emit('chat:userJoined', msg));
    socket.on("disconnect", () => { console.log("user disconnected") });
});

server.listen(3000, () => {
    console.log("Listening on port 3000");
});