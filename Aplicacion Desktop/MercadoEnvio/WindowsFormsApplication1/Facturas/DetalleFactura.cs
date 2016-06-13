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
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.Facturas
{
    public partial class DetalleFactura : Form
    {
        int codigoFactura;
        int codigoPublicacion;
        String destinatario;
        DateTime fechaFacturacion;
        decimal total;

        public DetalleFactura(int codigoFactura, int codigoPublicacion, String destinatario, DateTime fechaFacturacion, decimal total)
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
            this.codigoFactura = codigoFactura;
            this.codigoPublicacion = codigoPublicacion;
            this.destinatario = destinatario;
            this.fechaFacturacion = fechaFacturacion;
            this.total = total;
            this.inicializarCampos();
            ConfiguradorDataGrid.configurar(dataGridView1);
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.getItemsFactura(), dataGridView1);
        }

        private void inicializarCampos()
        {
            textBox1.Text = codigoFactura.ToString();
            textBox2.Text = codigoPublicacion.ToString();
            textBox3.Text = destinatario;
            textBox4.Text = fechaFacturacion.ToString();
            textBox5.Text = total.ToString();
        }

        private SqlDataReader getItemsFactura()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getItemsFactura(@codigoFactura)";
            consulta.Parameters.Add(new SqlParameter("@codigoFactura", this.codigoFactura));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            
            return reader;
        }
    }
}
