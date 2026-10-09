<!DOCTYPE html>
<html>
<head>
    <title>Formulario de Saludo</title>
</head>
<body>
    <h1>Ingresa tu nombre</h1>
    <form action="/servlet-saludo" method="POST">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required>
        <button type="submit">Enviar</button>
    </form>
</body>
</html>
