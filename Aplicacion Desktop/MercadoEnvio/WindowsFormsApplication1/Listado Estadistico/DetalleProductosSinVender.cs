using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication1.Listado_Estadistico
{
    public partial class DetalleProductosSinVender : Form
    {
        public DetalleProductosSinVender(int anio, int trimestre, String vendedor)
        {
            InitializeComponent();
            this.llenarDataGridConConsulta(this.productosSinVenderDeUnVendedor(anio, trimestre, vendedor));
        }

        private SqlDataReader productosSinVenderDeUnVendedor(int anio, int trimestre, String vendedor)
        {
            //TODO: ver si el nombre de parametro visibilidad esta bien

            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.productosSinVenderDeUnVendedor(@anio, @trimestre, @vendedor)";
            consulta.Parameters.Add(new SqlParameter("@anio", anio));
            consulta.Parameters.Add(new SqlParameter("@trimestre", trimestre));
            consulta.Parameters.Add(new SqlParameter("@vendedor", vendedor));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private void llenarDataGridConConsulta(SqlDataReader reader)
        {
            DataTable dt = new DataTable();
            dt.Load(reader);
            dataGridView1.AutoGenerateColumns = true;
            dataGridView1.DataSource = dt;
            dataGridView1.Refresh();
        }
    }
}
