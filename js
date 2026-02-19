// LAST STORE - FULLY FUNCTIONAL SINGLE FILE APP
// node index.js

const express = require("express");
const cors = require("cors");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const app = express();
app.use(cors());
app.use(express.json());

const PORT = 4000;
const SECRET = "LAST_STORE_SECRET";

/* =========================
   BASE DE DATOS EN MEMORIA
========================= */
const users = [];
const ads = [
  {
    id: 1,
    title: "Cuenta 1.2B Might T5",
    price: 350,
    might: "1.2B",
    castle: 25,
    image: "https://i.imgur.com/4ZQZ4Zy.png",
  },
  {
    id: 2,
    title: "Cuenta 800M Might T4",
    price: 180,
    might: "800M",
    castle: 25,
    image: "https://i.imgur.com/4ZQZ4Zy.png",
  },
];

/* =========================
   AUTH
========================= */
app.post("/api/register", async (req, res) => {
  const { username, email, password } = req.body;

  if (!username || !email || !password)
    return res.json({ error: "Datos incompletos" });

  if (users.find((u) => u.email === email))
    return res.json({ error: "Usuario ya existe" });

  const hash = await bcrypt.hash(password, 10);
  users.push({ id: users.length + 1, username, email, password: hash });

  res.json({ success: true });
});

app.post("/api/login", async (req, res) => {
  const { email, password } = req.body;
  const user = users.find((u) => u.email === email);

  if (!user) return res.json({ error: "Credenciales inválidas" });

  const ok = await bcrypt.compare(password, user.password);
  if (!ok) return res.json({ error: "Credenciales inválidas" });

  const token = jwt.sign({ id: user.id }, SECRET);
  res.json({ token, username: user.username });
});

/* =========================
   ADS
========================= */
app.get("/api/ads", (req, res) => res.json(ads));

/* =========================
   FRONTEND
========================= */
app.get("/", (req, res) => {
  res.send(`
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Last Store - Lords Mobile</title>
<style>
body{background:#0b1220;color:white;font-family:Arial;padding:40px}
h1{color:#facc15}
.card{background:#020617;padding:15px;border-radius:12px;width:220px}
.row{display:flex;gap:20px;flex-wrap:wrap}
img{width:100%;border-radius:8px}
input,button{width:100%;padding:8px;margin-top:6px;border-radius:6px;border:none}
button{background:#facc15;font-weight:bold;cursor:pointer}
small{color:#aaa}
</style>
</head>

<body>

<h1>Last Store</h1>
<p>Marketplace de Lords Mobile</p>

<h2>Registro</h2>
<input id="ruser" placeholder="Usuario">
<input id="remail" placeholder="Email">
<input id="rpass" type="password" placeholder="Contraseña">
<button onclick="register()">Registrarse</button>

<h2>Login</h2>
<input id="lemail" placeholder="Email">
<input id="lpass" type="password" placeholder="Contraseña">
<button onclick="login()">Entrar</button>

<h2>Anuncios</h2>
<div id="ads" class="row"></div>

<script>
async function register(){
  const res = await fetch('/api/register',{
    method:'POST',
    headers:{'Content-Type':'application/json'},
    body:JSON.stringify({
      username:ruser.value,
      email:remail.value,
      password:rpass.value
    })
  });
  const d = await res.json();
  alert(d.success ? 'Registrado correctamente' : d.error);
}

async function login(){
  const res = await fetch('/api/login',{
    method:'POST',
    headers:{'Content-Type':'application/json'},
    body:JSON.stringify({
      email:lemail.value,
      password:lpass.value
    })
  });
  const d = await res.json();
  alert(d.token ? 'Login correcto' : d.error);
}

async function loadAds(){
  const res = await fetch('/api/ads');
  const data = await res.json();
  data.forEach(a=>{
    ads.innerHTML += \`
      <div class="card">
        <img src="\${a.image}">
        <h4>\${a.title}</h4>
        <b style="color:#facc15">$\${a.price}</b>
        <small>Might: \${a.might}</small>
        <button>Ver anuncio</button>
      </div>
    \`
  });
}
loadAds();
</script>

<footer style="margin-top:40px">
<small>Last Store no está afiliado a IGG</small>
</footer>

</body>
</html>
`);
});

/* =========================
   START
========================= */
app.listen(PORT, () =>
  console.log("✅ Last Store funcionando → http://localhost:4000")
);
