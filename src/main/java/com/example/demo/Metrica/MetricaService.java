package com.example.demo.Metrica;

import java.util.List;

import com.example.demo.Producto.ProductoVendido;

public interface MetricaService {

    List<MetricaDia> serieDiaria(int dias);

    MetricaResumen resumen(List<MetricaDia> serie);

    List<ProductoVendido> productosMasVendidos(int dias);
}
