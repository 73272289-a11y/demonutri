package com.example.demo.Metrica;

import java.time.LocalDate;
import java.util.List;

import com.example.demo.Producto.ProductoVendido;

public interface MetricaRepository {

    List<MetricaDia> pedidosPorDia(LocalDate desde);

    List<ProductoVendido> productosMasVendidos(LocalDate desde, int limite);
}
