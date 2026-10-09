package com.example.demo.Metrica;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.demo.Producto.ProductoVendido;

@Repository
public class MetricaRepositoryImpl implements MetricaRepository {

    private final JdbcTemplate jdbcTemplate;

    public MetricaRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<MetricaDia> metricaDiaRowMapper = (rs, rowNum) -> {
        return new MetricaDia(
            rs.getDate("dia").toLocalDate(),
            rs.getInt("pedidos"),
            rs.getInt("entregados"),
            rs.getBigDecimal("ventas")
        );
    };

    private final RowMapper<ProductoVendido> productoVendidoRowMapper = (rs, rowNum) -> {
        return new ProductoVendido(
            rs.getString("nombre"),
            rs.getInt("cantidad"),
            rs.getBigDecimal("importe")
        );
    };

    public List<MetricaDia> pedidosPorDia(LocalDate desde) {
        String query = "SELECT CAST(fecha AS DATE) AS dia, "
                + "COUNT(*) AS pedidos, "
                + "SUM(CASE WHEN estado = 'ENTREGADO' THEN 1 ELSE 0 END) AS entregados, "
                + "SUM(CASE WHEN estado = 'ENTREGADO' THEN total ELSE 0 END) AS ventas "
                + "FROM pedido "
                + "WHERE fecha >= ? "
                + "GROUP BY CAST(fecha AS DATE) "
                + "ORDER BY dia";
        return jdbcTemplate.query(query, metricaDiaRowMapper, Date.valueOf(desde));
    }

    public List<ProductoVendido> productosMasVendidos(LocalDate desde, int limite) {
        String query = "SELECT pr.nombre AS nombre, "
                + "SUM(d.cantidad) AS cantidad, "
                + "SUM(d.cantidad * d.precio_unitario) AS importe "
                + "FROM detalle_pedido d "
                + "JOIN pedido p ON d.id_pedido = p.id "
                + "JOIN producto pr ON d.id_producto = pr.id "
                + "WHERE p.estado = 'ENTREGADO' AND p.fecha >= ? "
                + "GROUP BY pr.nombre "
                + "ORDER BY cantidad DESC, importe DESC "
                + "LIMIT ?";
        return jdbcTemplate.query(query, productoVendidoRowMapper, Date.valueOf(desde), limite);
    }
}
