using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApplication1.Dominio
{
    class Rol
    {
        public static List<String> getFuncionalidadesRol(String nombreRol)
        {
            List<String> funcionalidadesRol = new List<String>();
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getFuncionalidadesRol(@nombreRol)";
            consulta.Parameters.Add(new SqlParameter("@nombreRol", nombreRol));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            while (reader.Read())
                funcionalidadesRol.Add((String)reader.GetValue(0));

            return funcionalidadesRol;
        }

        public static int getIdRol(String nombreRol)
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getIdRol(@nombre_rol)";
            consulta.Parameters.Add(new SqlParameter("@nombre_rol", nombreRol));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (int)reader.GetValue(0);
        }
    }
}
