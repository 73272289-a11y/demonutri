package com.example.demo.Pedido;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class PedidoServiceImpl implements PedidoService {

    private final PedidoRepository repository;

    public PedidoServiceImpl(PedidoRepository repository) {
        this.repository = repository;
    }

    // Regla del negocio: se guarda el pedido, luego una línea por cada producto con cantidad > 0
    // y al final se calcula el total. Devuelve el código del pedido (0 si no eligió productos).
    public int registrar(Pedido pedido, List<Integer> idProducto, List<Integer> cantidad) {
        boolean hayProductos = false;
        for (Integer c : cantidad) {
            if (c != null && c > 0) {
                hayProductos = true;
            }
        }
        if (!hayProductos) {
            return 0;
        }

        repository.registrar(pedido);
        int codigo = repository.ultimoId();
        for (int i = 0; i < idProducto.size(); i++) {
            if (cantidad.get(i) != null && cantidad.get(i) > 0) {
                repository.registrarDetalle(codigo, idProducto.get(i), cantidad.get(i));
            }
        }
        repository.calcularTotal(codigo);
        return codigo;
    }

    public Pedido buscarSeguimiento(int codigo, String telefono) {
        return repository.buscarPorCodigoYTelefono(codigo, telefono);
    }

    public List<String> listarDetalle(int idPedido) {
        return repository.listarDetalle(idPedido);
    }

    public List<Pedido> listar() {
        return repository.listar();
    }

    public Pedido obtenerPorId(int id) {
        return repository.obtenerPorId(id);
    }

    public void asignar(int id, int idMotorizado) {
        repository.asignar(id, idMotorizado);
    }

    public List<Pedido> listarAsignados(int idMotorizado) {
        return repository.listarDeMotorizado(idMotorizado, "ASIGNADO");
    }

    public List<Pedido> listarEntregados(int idMotorizado) {
        return repository.listarDeMotorizado(idMotorizado, "ENTREGADO");
    }

    public void entregar(int id) {
        repository.entregar(id);
    }
}
