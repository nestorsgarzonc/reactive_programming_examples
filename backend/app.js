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
    socket.on('chat:message', (msg) => {
        console.log('chat:message', msg);
        io.emit('chat:message', msg);
    });
    socket.on('chat:join', (msg) => {
        console.log('chat:join', msg);
        io.emit('chat:userJoined', msg);
    });
    socket.on("disconnect", () => { console.log("user disconnected") });
});

server.listen(process.env.PORT || 3000, () => {
    console.log("Listening on port", process.env.PORT || 3000);
});