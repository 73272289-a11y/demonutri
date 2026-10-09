package com.example.demo.Usuario;

import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class UsuarioRepositoryImpl implements UsuarioRepository {

    private final JdbcTemplate jdbc;
    private final BeanPropertyRowMapper<Usuario> mapper = new BeanPropertyRowMapper<>(Usuario.class);

    public UsuarioRepositoryImpl(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public Usuario buscarPorUsernameYClave(String username, String clave) {
        List<Usuario> lista = jdbc.query(
                "SELECT * FROM usuario WHERE username = ? AND clave = ? AND activo = TRUE", mapper, username, clave);
        return lista.isEmpty() ? null : lista.get(0);
    }

    public List<Usuario> listar() {
        return jdbc.query("SELECT * FROM usuario", mapper);
    }

    public List<Usuario> listarMotorizadosActivos() {
        return jdbc.query("SELECT * FROM usuario WHERE rol = 'MOTORIZADO' AND activo = TRUE", mapper);
    }

    public Usuario obtenerPorId(int id) {
        return jdbc.queryForObject("SELECT * FROM usuario WHERE id = ?", mapper, id);
    }

    public void registrarMotorizado(Usuario u) {
        jdbc.update("INSERT INTO usuario (nombre, apellido, username, clave, rol) VALUES (?, ?, ?, ?, 'MOTORIZADO')",
                u.getNombre(), u.getApellido(), u.getUsername(), u.getClave());
    }

    public void actualizarMotorizado(Usuario u) {
        jdbc.update("UPDATE usuario SET nombre = ?, apellido = ?, clave = ? WHERE id = ?",
                u.getNombre(), u.getApellido(), u.getClave(), u.getId());
    }

    public void deshabilitar(int id) {
        jdbc.update("UPDATE usuario SET activo = FALSE WHERE id = ?", id);
    }
}
