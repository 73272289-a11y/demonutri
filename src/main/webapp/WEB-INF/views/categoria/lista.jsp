<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Categorías - Nutribubble</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilo.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/menu-admin.jsp"/>
<div class="caja">
<h1>Categorías</h1>
<a class="boton" href="${pageContext.request.contextPath}/categoria/nuevo">Nueva categoría</a>
<table>
    <tr><th>ID</th><th>Nombre</th><th>Descripción</th><th>Estado</th><th>Acciones</th></tr>
    <c:forEach items="${categorias}" var="c">
        <tr>
            <td>${c.id}</td>
            <td>${c.nombre}</td>
            <td>${c.descripcion}</td>
            <td>${c.activo ? 'Activa' : 'Deshabilitada'}</td>
            <td>
                <a href="${pageContext.request.contextPath}/categoria/editar?id=${c.id}">Editar</a>
                <c:if test="${c.activo}"><a href="${pageContext.request.contextPath}/categoria/deshabilitar?id=${c.id}">Deshabilitar</a></c:if>
            </td>
        </tr>
    </c:forEach>
</table>
</div>
</body>
</html>
