using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApplication1.Dominio
{
    class Empresa
    {
        public static int getIdEmpresa(String razonSocial, String cuit)
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getIdEmpresa(@razonSocial, @cuit)";
            consulta.Parameters.Add(new SqlParameter("@razonSocial", razonSocial));
            consulta.Parameters.Add(new SqlParameter("@cuit", cuit));

            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (int)reader.GetValue(0);
        }
    }
}
