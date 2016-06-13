using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApplication1.Dominio
{
    //Clase con metodos de clase para obtener datos del usuario

    class Usuario
    {
        public static String getTipoUsuario(String username)
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getTipoUsuario(@username)";
            consulta.Parameters.Add(new SqlParameter("@username", username));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (String)reader.GetValue(0);
        }

        public static int esUsuarioNuevo(String username)
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT GD1C2016.SALUDOS.esUsuarioNuevo(@username)";
            consulta.Parameters.Add(new SqlParameter("@username", username));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (int) reader.GetValue(0);
        }

        public static List<String> getRolesUsuario(String username)
        {
            List<String> rolesUsuario = new List<String>();
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getRolesUsuario(@username)";
            consulta.Parameters.Add(new SqlParameter("@username", username));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            while (reader.Read())
                rolesUsuario.Add((String)reader.GetValue(0));

            return rolesUsuario;
        }

        public static int cantidadCalificacionesPendientes(String username)
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT GD1C2016.SALUDOS.cantidadCalificacionesPendientes(@usuario)";
            consulta.Parameters.Add(new SqlParameter("@usuario", username));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (int)reader.GetValue(0);
        }
    }
}
