using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.ComprarOfertar
{
    public partial class Comprar : Form
    {
        int codigoPublicacion;
        String username;

        public Comprar(int codigoPublicacion, String username)
        {
            InitializeComponent();
            this.codigoPublicacion = codigoPublicacion;
            this.username = username;
            this.inicializarCampos();
        }

        private SqlDataReader detallesPublicacionCompraInmediata()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.detallesPublicacionCompraInmediata(@codigo)";
            consulta.Parameters.Add(new SqlParameter("@codigo", this.codigoPublicacion));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return reader;
        }

        private void inicializarCampos()
        {
            SqlDataReader detallesPublicacionCompraInmediata = this.detallesPublicacionCompraInmediata();

            this.inicializarDescripcion(detallesPublicacionCompraInmediata);
            this.inicializarPrecioUnitario(detallesPublicacionCompraInmediata);
            this.inicializarRubro(detallesPublicacionCompraInmediata);
            this.inicializarStock(detallesPublicacionCompraInmediata);
            this.inicializarPermiteEnvio(detallesPublicacionCompraInmediata);
            this.inicializarPrecioTotal(detallesPublicacionCompraInmediata);
        }

        private void inicializarDescripcion(SqlDataReader detallesPublicacionCompraInmediata)
        {
            textBox3.Text = detallesPublicacionCompraInmediata.GetValue(0).ToString();
        }

        private void inicializarPrecioUnitario(SqlDataReader detallesPublicacionCompraInmediata)
        {
            textBox1.Text = detallesPublicacionCompraInmediata.GetValue(1).ToString();
        }

        private void inicializarPrecioTotal(SqlDataReader detallesPublicacionCompraInmediata)
        {
            decimal precioUnitario = Convert.ToDecimal(detallesPublicacionCompraInmediata.GetValue(1));
            textBox2.Text = Convert.ToString((Convert.ToInt32(numericUpDown1.Value)) * precioUnitario);
        }

        private void inicializarRubro(SqlDataReader detallesPublicacionCompraInmediata)
        {
            textBox5.Text = detallesPublicacionCompraInmediata.GetValue(2).ToString();
        }

        //Setea el numero de unidades maximas que se pueden comprar
        private void inicializarStock(SqlDataReader detallesPublicacionCompraInmediata)
        {
            numericUpDown1.Maximum = Convert.ToDecimal(detallesPublicacionCompraInmediata.GetValue(3));
        }

        private void inicializarPermiteEnvio(SqlDataReader detallesPublicacionCompraInmediata)
        {
            int permiteEnvio = Convert.ToInt32(detallesPublicacionCompraInmediata.GetValue(4));

            if (permiteEnvio.Equals(1))
                checkBox1.Show();
            else
            {
                checkBox1.Hide();
                checkBox1.Checked = false;
            }
        }

        private void numericUpDown1_ValueChanged(object sender, EventArgs e)
        {
            this.inicializarPrecioTotal(this.detallesPublicacionCompraInmediata());
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private int optaPorEnvio()
        {
            if (checkBox1.Checked)
                return 1;
            else
                return 0;
        }

        private void comprar()
        {
            int cantidadComprada = Convert.ToInt32(numericUpDown1.Value);

            SQLManager manager = new SQLManager().generarSP("comprar")
                                 .agregarIntSP("@codPublicacion", this.codigoPublicacion)
                                 .agregarIntSP("@cantidadComprada", cantidadComprada)
                                 .agregarStringSP("@usuario", this.username)
                                 .agregarIntSP("@optaEnvio", this.optaPorEnvio());

            manager.ejecutarSP();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.comprar();
        }
    }
}
