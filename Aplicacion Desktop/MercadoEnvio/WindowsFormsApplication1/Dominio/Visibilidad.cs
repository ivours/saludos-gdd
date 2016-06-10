using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApplication1.Dominio
{
    class Visibilidad
    {
        public static List<String> getNombresVisibilidades()
        {
            List<String> visibilidades = new List<String>();
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getNombresVisibilidades()";
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            while (reader.Read())
                visibilidades.Add((String)reader.GetValue(0));

            return visibilidades;
        }

        public static decimal getComisionPublicacion(String nombreVisibilidad)
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getComisionPublicacion(@nombreVisibilidad)";
            consulta.Parameters.Add(new SqlParameter("@nombreVisibilidad", nombreVisibilidad));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return (decimal) reader.GetValue(0) ;
        }

        public static decimal getComisionVenta(String nombreVisibilidad)
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getComisionVenta(@nombreVisibilidad)";
            consulta.Parameters.Add(new SqlParameter("@nombreVisibilidad", nombreVisibilidad));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return (decimal)reader.GetValue(0);
        }

        public static decimal getComisionEnvio(String nombreVisibilidad)
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getComisionEnvio(@nombreVisibilidad)";
            consulta.Parameters.Add(new SqlParameter("@nombreVisibilidad", nombreVisibilidad));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return (decimal)reader.GetValue(0);
        }
    }
}
