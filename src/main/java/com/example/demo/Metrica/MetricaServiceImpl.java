package com.example.demo.Metrica;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.Producto.ProductoVendido;

@Service
public class MetricaServiceImpl implements MetricaService {

    private static final int TOP_PRODUCTOS = 5;

    private final MetricaRepository metricaRepository;

    public MetricaServiceImpl(MetricaRepository metricaRepository) {
        this.metricaRepository = metricaRepository;
    }

    public List<MetricaDia> serieDiaria(int dias) {
        LocalDate hoy = LocalDate.now();
        LocalDate desde = hoy.minusDays(dias - 1);
        List<MetricaDia> conPedidos = metricaRepository.pedidosPorDia(desde);

        List<MetricaDia> serie = new ArrayList<>();
        for (LocalDate fecha = desde; !fecha.isAfter(hoy); fecha = fecha.plusDays(1)) {
            MetricaDia dia = buscarDia(conPedidos, fecha);
            if (dia == null) {
                dia = new MetricaDia(fecha, 0, 0, BigDecimal.ZERO);
            }
            serie.add(dia);
        }
        return serie;
    }

    private MetricaDia buscarDia(List<MetricaDia> lista, LocalDate fecha) {
        for (MetricaDia dia : lista) {
            if (dia.getFecha().equals(fecha)) {
                return dia;
            }
        }
        return null;
    }

    public MetricaResumen resumen(List<MetricaDia> serie) {
        BigDecimal ventas = BigDecimal.ZERO;
        int pedidos = 0;
        int entregados = 0;
        for (MetricaDia dia : serie) {
            ventas = ventas.add(dia.getVentas());
            pedidos += dia.getPedidos();
            entregados += dia.getEntregados();
        }

        BigDecimal ticketPromedio = BigDecimal.ZERO;   // si no hay entregas se queda en 0
        if (entregados > 0) {
            ticketPromedio = ventas.divide(BigDecimal.valueOf(entregados), 2, RoundingMode.HALF_UP);
        }
        return new MetricaResumen(ventas, pedidos, entregados, ticketPromedio);
    }

    public List<ProductoVendido> productosMasVendidos(int dias) {
        LocalDate desde = LocalDate.now().minusDays(dias - 1);
        return metricaRepository.productosMasVendidos(desde, TOP_PRODUCTOS);
    }
}
