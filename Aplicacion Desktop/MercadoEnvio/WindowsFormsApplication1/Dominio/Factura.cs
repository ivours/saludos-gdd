using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApplication1.Dominio
{
    class Factura
    {
        public static List<Item> getItemsFactura(int codigoFactura)
        {
            List<Item> itemsFactura = new List<Item>();
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getItemsFactura(@codigoFactura)";
            consulta.Parameters.Add(new SqlParameter("@codigoFactura", codigoFactura));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            while (reader.Read())
            {
                Item item = new Item();
                item.setDescripcion((String)reader.GetValue(0));
                item.setImporte((decimal)reader.GetValue(1));
                item.setCantidad((int)reader.GetValue(2));
                itemsFactura.Add(item);
            }

            return itemsFactura;
        }
    }
}
