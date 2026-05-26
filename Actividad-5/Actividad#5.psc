const express = require("express");
const mongoose = require("mongoose");

const app = express();
const PORT = 3000;

// API KEY
const API_KEY = "mi_apikey_123";

// Middleware JSON
app.use(express.json());

// Conexión MongoDB
mongoose
.connect("mongodb://127.0.0.1:27017/todoDB")
.then(() => {
console.log("Conectado a MongoDB");
})
.catch((error) => {
console.log("Error de conexión:", error);
});

// Middleware Authorization
app.use((req, res, next) => {
const authHeader = req.headers.authorization;

if (!authHeader | authHeader <>= API_KEY) {
return res.status(401).json({
message: "API KEY inválida",
    });
	}
	
	next();
	});
	
	// Schemas
	const taskSchema = new mongoose.Schema({
title: String,
date: String,
	});
	
	const goalSchema = new mongoose.Schema({
title: String,
date: String,
	});
	
	// Models
	const Task = mongoose.model("Task", taskSchema);
	const Goal = mongoose.model("Goal", goalSchema);
	
	
	// =======================
	// GET TASKS
	// =======================
	app.get("/getTasks", async (req, res) => {
	try {
    const tasks = await Task.find();
	
    return res.status(200).json(tasks);
	
	} catch (error) {
    return res.status(500).json({
message: "Error obteniendo tareas",
    });
	}
	});
	
	
	// =======================
	// GET GOALS
	// =======================
	app.get("/getGoals", async (req, res) => {
	try {
    const goals = await Goal.find();
	
    return res.status(200).json(goals);
	
	} catch (error) {
    return res.status(500).json({
message: "Error obteniendo metas",
    });
	}
	});
	
	
	// =======================
	// ADD TASK
	// =======================
	app.post("/addTask", async (req, res) => {
	try {
    const { title, date } = req.body;
	
    if (!title | !date) {
	return res.status(400).json({
message: "Parámetros incorrectos",
	});
    }
	
    const newTask = new Task({
	title,
	date,
    });
	
    await newTask.save();
	
    return res.status(200).json({
message: "Tarea agregada",
task: newTask,
    });
	
	} catch (error) {
    return res.status(500).json({
message: "Error agregando tarea",
    });
	}
	});
	
	
	// =======================
	// ADD GOAL
	// =======================
	app.post("/addGoal", async (req, res) => {
	try {
    const { title, date } = req.body;
	
    if (!title | !date) {
	return res.status(400).json({
message: "Parámetros incorrectos",
	});
    }
	
    const newGoal = new Goal({
	title,
	date,
    });
	
    await newGoal.save();
	
    return res.status(200).json({
message: "Meta agregada",
goal: newGoal,
    });
	
	} catch (error) {
    return res.status(500).json({
message: "Error agregando meta",
    });
	}
	});
	
	
	// =======================
	// REMOVE TASK
	// =======================
	app.delete("/removeTask/:id", async (req, res) => {
	try {
    const { id } = req.params;
	
    await Task.findByIdAndDelete(id);
	
    return res.status(200).json({
message: "Tarea eliminada",
    });
	
	} catch (error) {
    return res.status(400).json({
message: "ID inválido",
    });
	}
	});
	
	
	// =======================
	// REMOVE GOAL
	// =======================
	app.delete("/removeGoal/:id", async (req, res) => {
	try {
    const { id } = req.params;
	
    await Goal.findByIdAndDelete(id);
	
    return res.status(200).json({
message: "Meta eliminada",
    });
	
	} catch (error) {
    return res.status(400).json({
message: "ID inválido",
    });
	}
	});
	
	
	// =======================
	// SERVER
	// =======================
	app.listen(PORT, () => {
console.log(`Servidor ejecutándose en http://localhost:${PORT}`);
});