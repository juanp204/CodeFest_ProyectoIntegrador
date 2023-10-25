const router = require('express').Router();
const path = require('path');
const conectado = require('../database/mysql');

const rootdir = __dirname.slice(0, -6);

// Función para renderizar alertas de error
function renderErrorAlert(pagina, message) {
    res.render(path.join(rootdir, `views/${pagina}.html`), {
        us: req.session.user,
        id: req.session.tipeuser,
        alert: true,
        alertTitle: "Error",
        alertMessage: message,
        alertIcon: "error",
        showConfirmButton: true,
        timer: false
    });
}

// Página de inicio
router.get('/', async (req, res) => {
    res.send('CodeFest');
});

// Cerrar sesión
router.get('/cerrarsesion', async (req, res) => {
    req.session.destroy();
    res.redirect('/');
});

// Registro de usuario
router.post('/register', async (req, res) => {
    const { email, name, apellido, pass } = req.body;

    if (email && name && pass) {
        conectado.query('SELECT * FROM usuarios WHERE correo = ?', [email], async (error, results) => {
            if (error) {
                renderErrorAlert(res, "Ocurrió un error inesperado");
            } else if (results.length === 0) {
                const newUser = {
                    correo: email,
                    nombres: name,
                    apellidos: apellido,
                    passwd: pass,
                    tipousuario_idtipousuario: 2
                };

                conectado.query('INSERT INTO usuarios SET ?', newUser, async (error, result) => {
                    if (error) {
                        renderErrorAlert("register", "Ocurrió un error inesperado");
                    } else {
                        res.redirect('/login.html');
                    }
                });
            } else {
                renderErrorAlert("register", "El email ya está ocupado");
            }
        });
    } else {
        renderErrorAlert("register", "Espacios vacíos");
    }
});

// Autenticación de usuario
router.post('/auth', async (req, res) => {
    const { username, password, remember } = req.body;

    if (username && password) {
        conectado.query('SELECT * FROM usuarios WHERE correo = ? ', [username], (error, results) => {
            if (error || results.length === 0 || password !== results[0].passwd) {
                renderErrorAlert(res, "Usuario y/o contraseña incorrecta");
            } else {
                req.session.loggedin = true;
                req.session.user = results[0].correo;
                req.session.name = results[0].nombres;
                req.session.apellido = results[0].apellidos;
                req.session.iduser = results[0].idtipousuario;
                req.session.tipeuser = results[0].tipousuario_idtipousuario;

                if (!remember) {
                    req.session.cookie.expires = false;
                }
                res.redirect('/usuario.html');
            }
        });
    } else {
        renderErrorAlert("login", "Campos vacíos");
    }
});

module.exports = router;
