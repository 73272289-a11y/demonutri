<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Métricas - Nutribubble</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilo.css">
    <style>

        .encabezado { display: flex; align-items: center; justify-content: space-between; gap: 16px; }
        .filtros { display: flex; gap: 8px; }
        .filtros a { padding: 6px 14px; border: 1px solid #d8e3d3; border-radius: 999px; background: white;
                     color: #1f2a22; font-size: 14px; font-weight: bold; text-decoration: none; }
        .filtros a.activo { background: #2e7d32; border-color: #2e7d32; color: white; }

        .indicadores { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin: 10px 0 28px; }
        .indicador { background: #f4f7f2; border-top: 4px solid #2e7d32; border-radius: 6px; padding: 16px 18px; }
        .indicador span { display: block; color: #5f6e63; font-size: 14px; font-weight: bold; }
        .indicador strong { font-size: 28px; color: #1e4a2b; }

        .grafico { border: 1px solid #d8e3d3; border-radius: 6px; padding: 20px; margin-bottom: 24px; }
        .grafico h2 { margin: 0; font-size: 20px; color: #1f2a22; }
        .ayuda { margin: 4px 0 12px; font-size: 13px; color: #5f6e63; }
        .grafico-lienzo { position: relative; height: 280px; }

        .vacio { color: #5f6e63; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/menu-admin.jsp"/>
<div class="caja">

<div class="encabezado">
    <h1>Métricas</h1>
    <nav class="filtros">
        <c:set var="base" value="${pageContext.request.contextPath}/metricas" />
        <a class="${dias == 7 ? 'activo' : ''}" href="${base}?dias=7">7 días</a>
        <a class="${dias == 14 ? 'activo' : ''}" href="${base}?dias=14">14 días</a>
        <a class="${dias == 30 ? 'activo' : ''}" href="${base}?dias=30">30 días</a>
    </nav>
</div>

<section class="indicadores">
    <div class="indicador">
        <span>Ventas entregadas</span>
        <strong>S/ ${resumen.ventas}</strong>
    </div>
    <div class="indicador">
        <span>Pedidos registrados</span>
        <strong>${resumen.pedidos}</strong>
    </div>
    <div class="indicador">
        <span>Pedidos entregados</span>
        <strong>${resumen.entregados}</strong>
    </div>
    <div class="indicador">
        <span>Ticket promedio</span>
        <strong>S/ ${resumen.ticketPromedio}</strong>
    </div>
</section>

<section class="grafico">
    <h2>Ventas por día (S/)</h2>
    <p class="ayuda">Suma de los pedidos entregados, según el día en que se registraron.</p>
    <div class="grafico-lienzo"><canvas id="graficoVentas"></canvas></div>
</section>

<section class="grafico">
    <h2>Pedidos por día</h2>
    <p class="ayuda">Pedidos registrados por los clientes y cuántos de ellos ya se entregaron.</p>
    <div class="grafico-lienzo"><canvas id="graficoPedidos"></canvas></div>
</section>

<section>
    <h2>Productos más vendidos</h2>
    <c:if test="${empty topProductos}">
        <p class="vacio">Aún no hay pedidos entregados en este período.</p>
    </c:if>
    <c:if test="${not empty topProductos}">
        <table>
            <tr>
                <th>Producto</th>
                <th>Unidades</th>
                <th>Importe</th>
            </tr>
            <c:forEach items="${topProductos}" var="producto">
                <tr>
                    <td><c:out value="${producto.nombre}" /></td>
                    <td>${producto.cantidad}</td>
                    <td>S/ ${producto.importe}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</section>

</div>

<!-- Chart.js: librería de JavaScript que dibuja los gráficos de líneas dentro de cada <canvas> -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.js"></script>
<script>
    // Los arreglos se arman con c:forEach a partir de la serie que manda el controller
    // Ejemplo de lo que llega al navegador: const fechas = ['01/10','02/10', ...];
    const fechas = [<c:forEach items="${serie}" var="dia" varStatus="s">'${dia.fechaTexto}'${s.last ? '' : ','}</c:forEach>];
    const ventas = [<c:forEach items="${serie}" var="dia" varStatus="s">${dia.ventas}${s.last ? '' : ','}</c:forEach>];
    const pedidos = [<c:forEach items="${serie}" var="dia" varStatus="s">${dia.pedidos}${s.last ? '' : ','}</c:forEach>];
    const entregados = [<c:forEach items="${serie}" var="dia" varStatus="s">${dia.entregados}${s.last ? '' : ','}</c:forEach>];

    // Opciones que comparten los dos gráficos
    const opciones = {
        responsive: true,
        maintainAspectRatio: false,
        interaction: { mode: 'index', intersect: false },          // al pasar el mouse muestra todos los valores del día
        scales: { y: { beginAtZero: true, ticks: { precision: 0 } } } // eje Y desde 0 y sin decimales
    };

    new Chart(document.getElementById('graficoVentas'), {
        type: 'line',
        data: {
            labels: fechas,
            datasets: [{
                label: 'Ventas (S/)',
                data: ventas,
                borderColor: '#2e7d32',
                backgroundColor: 'rgba(46, 125, 50, 0.12)',
                fill: true,      // pinta el área debajo de la línea
                tension: 0.3     // hace la línea un poco curva
            }]
        },
        options: opciones
    });

    new Chart(document.getElementById('graficoPedidos'), {
        type: 'line',
        data: {
            labels: fechas,
            datasets: [{
                label: 'Registrados',
                data: pedidos,
                borderColor: '#E8A33D',
                backgroundColor: '#E8A33D',
                tension: 0.3
            }, {
                label: 'Entregados',
                data: entregados,
                borderColor: '#2e7d32',
                backgroundColor: '#2e7d32',
                tension: 0.3
            }]
        },
        options: opciones
    });
</script>
</body>
</html>
