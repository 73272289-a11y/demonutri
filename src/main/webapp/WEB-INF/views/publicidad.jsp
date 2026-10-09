<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Conoce lo que comes - Nutribubble</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilo.css">
    <style>
        .caja { max-width: 1000px; }
        .intro { text-align: center; margin-bottom: 26px; }
        .intro h1 { font-size: 34px; margin-bottom: 6px; letter-spacing: 1px; }
        .intro p { color: #5f6e63; margin: 0; font-size: 16px; }

        .platos { display: grid; grid-template-columns: repeat(3, 1fr); gap: 18px; }
        .plato { border: 1px solid #d8e3d3; border-radius: 10px; padding: 18px; background: #fbfdf9; }
        .plato .icono { font-size: 34px; }
        .plato h3 { margin: 6px 0 2px; color: #1f2a22; font-size: 19px; }
        .plato .categoria { color: #5f6e63; font-size: 13px; }

        .dato { display: flex; justify-content: space-between; padding: 7px 0; border-bottom: 1px dashed #d8e3d3; font-size: 15px; }
        .dato:last-of-type { border-bottom: none; }
        .dato b { color: #2e7d32; }
        .datos { margin: 12px 0; }

        .etiqueta { display: inline-block; padding: 4px 12px; border-radius: 999px; font-size: 13px; font-weight: bold; }
        .verde   { background: #e8f5e9; color: #2e7d32; }
        .naranja { background: #fff3e0; color: #e65100; }
        .azul    { background: #e3f2fd; color: #1565c0; }
        .gris    { background: #eeeeee; color: #616161; }

        .frase { text-align: center; margin: 34px 0 6px; font-size: 22px; font-style: italic; color: #2e7d32; }
        .nota { text-align: center; color: #888; font-size: 12px; margin: 0; }
    </style>
</head>
<body>
<div class="menu">
    <b>Nutribubble</b>
    <a href="${pageContext.request.contextPath}/catalogo">Catálogo</a>
    <a href="${pageContext.request.contextPath}/pedido/nuevo">Hacer pedido</a>
    <a href="${pageContext.request.contextPath}/pedido/seguimiento">Seguir mi pedido</a>
    <a href="${pageContext.request.contextPath}/publicidad">Conoce lo que comes</a>
    <a href="${pageContext.request.contextPath}/contacto">Contacto</a>
    <a href="${pageContext.request.contextPath}/login">Ingresar</a>
</div>
<div class="caja">

<div class="intro">
    <h1>CONOCE LO QUE COMES</h1>
    <p>Cada plato de Nutribubble está pensado para darte energía sin descuidar tu salud.</p>
</div>

<div class="platos">

    <div class="plato">
        <div class="icono">🍗</div>
        <h3>Bowl de pollo</h3>
        <div class="categoria">Bowls</div>
        <div class="datos">
            <div class="dato"><span>🔥 Calorías</span><b>450 kcal</b></div>
            <div class="dato"><span>💪 Proteína</span><b>35 g</b></div>
            <div class="dato"><span>🌾 Carbohidratos</span><b>40 g</b></div>
        </div>
        <span class="etiqueta verde">Alto en proteína</span>
    </div>

    <div class="plato">
        <div class="icono">🥑</div>
        <h3>Bowl de quinua</h3>
        <div class="categoria">Bowls</div>
        <div class="datos">
            <div class="dato"><span>🔥 Calorías</span><b>420 kcal</b></div>
            <div class="dato"><span>💪 Proteína</span><b>16 g</b></div>
            <div class="dato"><span>🥬 Fibra</span><b>9 g</b></div>
        </div>
        <span class="etiqueta verde">100% vegetariano</span>
    </div>

    <div class="plato">
        <div class="icono">🥤</div>
        <h3>Jugo verde</h3>
        <div class="categoria">Bebidas</div>
        <div class="datos">
            <div class="dato"><span>🔥 Calorías</span><b>120 kcal</b></div>
            <div class="dato"><span>🍊 Vitamina C</span><b>Alta</b></div>
            <div class="dato"><span>🍬 Azúcar añadida</span><b>0 g</b></div>
        </div>
        <span class="etiqueta naranja">Sin azúcar añadida</span>
    </div>

    <div class="plato">
        <div class="icono">🍋</div>
        <h3>Limonada de chía</h3>
        <div class="categoria">Bebidas</div>
        <div class="datos">
            <div class="dato"><span>🔥 Calorías</span><b>90 kcal</b></div>
            <div class="dato"><span>🌱 Omega 3</span><b>Sí</b></div>
            <div class="dato"><span>💧 Hidratación</span><b>Alta</b></div>
        </div>
        <span class="etiqueta azul">Refrescante</span>
    </div>

    <div class="plato">
        <div class="icono">🥗</div>
        <h3>Ensalada fresca</h3>
        <div class="categoria">Acompañamientos</div>
        <div class="datos">
            <div class="dato"><span>🔥 Calorías</span><b>180 kcal</b></div>
            <div class="dato"><span>🥬 Fibra</span><b>6 g</b></div>
            <div class="dato"><span>🥕 Vitamina A</span><b>Alta</b></div>
        </div>
        <span class="etiqueta verde">Bajo en calorías</span>
    </div>

    <div class="plato">
        <div class="icono">🌯</div>
        <h3>Wrap integral</h3>
        <div class="categoria">Acompañamientos</div>
        <div class="datos">
            <div class="dato"><span>🔥 Calorías</span><b>380 kcal</b></div>
            <div class="dato"><span>💪 Proteína</span><b>25 g</b></div>
            <div class="dato"><span>🌾 Harina</span><b>Integral</b></div>
        </div>
        <span class="etiqueta gris">Próximamente</span>
    </div>

</div>

<p class="frase">"Comer sano también puede ser delicioso."</p>
<p class="nota">* Valores aproximados por porción.</p>

</div>
</body>
</html>
