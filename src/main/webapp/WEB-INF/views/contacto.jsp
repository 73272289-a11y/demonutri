<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contacto - Nutribubble</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilo.css">
    <style>
        .caja { max-width: 950px; }
        .subtitulo { color: #5f6e63; margin-top: -10px; }

        .contacto { display: grid; grid-template-columns: 1fr 1.6fr; gap: 26px; margin-top: 20px; }

        .info { background: #2e7d32; color: white; border-radius: 10px; padding: 24px; }
        .info h2 { margin-top: 0; font-size: 20px; }
        .info .item { margin-bottom: 18px; }
        .info .item span { display: block; font-size: 13px; opacity: 0.8; }
        .info .item b { font-size: 16px; }

        .formulario { border: 1px solid #d8e3d3; border-radius: 10px; padding: 24px; }
        .formulario h2 { margin-top: 0; font-size: 20px; color: #1f2a22; }
        .formulario input, .formulario select, .formulario textarea {
            width: 100%; box-sizing: border-box; padding: 9px; border: 1px solid #ccc; border-radius: 6px; font-family: Arial, sans-serif; }
        .formulario textarea { height: 110px; resize: vertical; }
        .fila { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
        .formulario button { width: 100%; padding: 11px; border-radius: 6px; font-size: 15px; cursor: pointer; }

        .exito { background: #e8f5e9; border-left: 5px solid #2e7d32; color: #1e4a2b; padding: 12px 16px; border-radius: 6px; margin-bottom: 14px; }
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

<h1>Contáctanos</h1>
<p class="subtitulo">¿Tienes una consulta, sugerencia o quieres pedir para un evento? Escríbenos.</p>

<div class="contacto">

    <!-- Columna izquierda: datos del negocio -->
    <div class="info">
        <h2>Nutribubble</h2>
        <div class="item"><span>📍 Zona de reparto</span><b>Huancayo, El Tambo y Chilca</b></div>
        <div class="item"><span>📱 WhatsApp / Yape</span><b>987 654 321</b></div>
        <div class="item"><span>✉️ Correo</span><b>contacto@nutribubble.com</b></div>
        <div class="item"><span>🕐 Horario</span><b>Lunes a sábado, 11:00 a.m. – 9:00 p.m.</b></div>
    </div>

    <!-- Columna derecha: formulario -->
    <div class="formulario">
        <h2>Envíanos un mensaje</h2>

        <!-- Solo aparece después de enviar: el controller manda "enviado" con el nombre -->
        <c:if test="${not empty enviado}">
            <div class="exito">¡Gracias, <c:out value="${enviado}"/>! Recibimos tu mensaje y te responderemos pronto.</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/contacto" method="post">
            <div class="fila">
                <div>
                    <label>Nombre</label>
                    <input type="text" name="nombre" required>
                </div>
                <div>
                    <label>Celular</label>
                    <input type="text" name="celular" pattern="[0-9]{9}" placeholder="9 dígitos">
                </div>
            </div>

            <label>Correo</label>
            <input type="email" name="correo" required>

            <label>Asunto</label>
            <select name="asunto">
                <option>Consulta</option>
                <option>Sugerencia</option>
                <option>Reclamo</option>
                <option>Pedido para eventos</option>
            </select>

            <label>Mensaje</label>
            <textarea name="mensaje" required></textarea>

            <button type="submit">Enviar mensaje</button>
        </form>
    </div>

</div>
</div>
</body>
</html>
