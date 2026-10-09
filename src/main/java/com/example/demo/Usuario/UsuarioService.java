package com.example.demo.Usuario;

import java.util.List;

public interface UsuarioService {
    Usuario autenticar(String username, String clave);
    List<Usuario> listar();
    List<Usuario> listarMotorizadosActivos();
    Usuario obtenerPorId(int id);
    void registrarMotorizado(Usuario usuario);
    void actualizarMotorizado(Usuario usuario);
    void deshabilitar(int id);
}
