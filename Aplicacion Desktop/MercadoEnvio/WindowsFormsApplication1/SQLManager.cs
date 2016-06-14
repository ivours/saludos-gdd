using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    class SQLManager
    {
        public SqlCommand command;

        public SQLManager generarSP(String nombre)
        {
            command = new SqlCommand();
            command.Connection = Program.conexionDB();
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.CommandText = "[GD1C2016].[SALUDOS].[" + nombre + "]";
            command.CommandTimeout = 0;
            return this;
        }

        public Object ejecutarSP()
        {
            return command.ExecuteScalar();
        }

        public SQLManager agregarStringSP(String nombreVariable, String texto)
        {
            command.Parameters.AddWithValue(nombreVariable, texto);
            return this;
        }

        public SQLManager agregarFechaSP(string nombreVariable, DateTime dateTime)
        {
            command.Parameters.AddWithValue(nombreVariable, dateTime);
            return this;
        }

        public SQLManager agregarIntSP(string nombreVariable, int numero)
        {
            command.Parameters.AddWithValue(nombreVariable, Convert.ToInt32(numero));
            return this;
        }

        public SQLManager agregarLongSP(string nombreVariable, long numero)
        {
            command.Parameters.AddWithValue(nombreVariable, Convert.ToInt64(numero));
            return this;
        }

        public SQLManager agregarDecimalSP(string nombreVariable, decimal numero)
        {
            command.Parameters.AddWithValue(nombreVariable, numero);
            return this;
        }

    }
}
