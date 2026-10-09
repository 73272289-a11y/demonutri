package com.example.demo.Metrica;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MetricaController {

    private final MetricaService metricaService;

    public MetricaController(MetricaService metricaService) {
        this.metricaService = metricaService;
    }

    @GetMapping("/metricas")
    public String metricas(@RequestParam(value = "dias", defaultValue = "14") int dias, Model model) {
        // Solo se permiten estos períodos
        if (dias != 7 && dias != 14 && dias != 30) {
            dias = 14;
        }
        List<MetricaDia> serie = metricaService.serieDiaria(dias);

        model.addAttribute("dias", dias);
        model.addAttribute("serie", serie);
        model.addAttribute("resumen", metricaService.resumen(serie));
        model.addAttribute("topProductos", metricaService.productosMasVendidos(dias));
        return "metricas";
    }
}
