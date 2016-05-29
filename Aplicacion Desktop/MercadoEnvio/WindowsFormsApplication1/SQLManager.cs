using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace WindowsFormsApplication1
{
    class SQLManager
    {
        public SqlCommand command;

        public SQLManager generarSP(string nombre)
        {
            command = new SqlCommand();
            command.Connection = Program.conexionDB();
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.CommandText = "[GD1C2016].[SALUDOS].[" + nombre + "]";
            command.CommandTimeout = 0;
            return this;
        }

        public SQLManager agregarStringSP(String nombreVariable, String texto)
        {
            command.Parameters.AddWithValue(nombreVariable, texto);
            return this;
        }

        public Object ejecutarSP()
        {
            return command.ExecuteScalar();
        }

    }
}
