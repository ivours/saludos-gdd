using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApplication1.Dominio
{
    class Cliente
    {
        public static int getIdCliente(String tipoDocumento, int nroDocumento)
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getIdCliente(@tipoDocumento, @nroDocumento)";
            consulta.Parameters.Add(new SqlParameter("@tipoDocumento", tipoDocumento));
            consulta.Parameters.Add(new SqlParameter("@nroDocumento", nroDocumento));

            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (int)reader.GetValue(0);
        }
    }
}
