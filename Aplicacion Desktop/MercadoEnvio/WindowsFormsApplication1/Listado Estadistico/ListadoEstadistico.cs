using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Dominio;

namespace WindowsFormsApplication1.Listado_Estadistico
{
    public partial class ListadoEstadistico : Form
    {
        public ListadoEstadistico()
        {
            InitializeComponent();
            this.llenarComboBoxDeTiposDeConsultas();
            this.llenarComboBoxVisibilidades();
            this.llenarComboBoxTrimestres();
            comboBox1.SelectedIndexChanged += OnSelectedIndexChanged;
        }

        private void llenarComboBoxDeTiposDeConsultas()
        {
            comboBox1.Items.Add("Vendedores con mayor cantidad de productos no vendidos");
            comboBox1.Items.Add("Clientes con mayor cantidad de productos comprados");
            comboBox1.Items.Add("Vendedores con mayor cantidad de facturas");
            comboBox1.Items.Add("Vendedores con mayor monto facturado");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (comboBox1.SelectedIndex == 2)
                this.llenarDataGridConConsulta(this.vendedoresConMasFacturas());
        }

        private void llenarDataGridConConsulta(SqlDataReader reader)
        {
            DataTable dt = new DataTable();
            dt.Load(reader);
            dataGridView1.AutoGenerateColumns = true;
            dataGridView1.DataSource = dt;
            dataGridView1.Refresh();
        }

        private SqlDataReader vendedoresConMasFacturas()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.vendedoresConMasFacturas(@anio, @trimestre)";
            consulta.Parameters.Add(new SqlParameter("@anio", 2015));
            consulta.Parameters.Add(new SqlParameter("@trimestre", 1));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private void OnSelectedIndexChanged(object sender, EventArgs e)
        {

            label4.Hide();
            label5.Hide();
            comboBox3.Hide();
            button3.Hide();

            switch (comboBox1.SelectedItem.ToString())
            {
                case "Vendedores con mayor cantidad de productos no vendidos":
                    label4.Show();
                    comboBox3.Show();
                    break;

                case "Clientes con mayor cantidad de productos comprados":
                    label5.Show();
                    button3.Show();
                    break;
            }

        }

        private void llenarComboBoxVisibilidades()
        {
            //List<String> visibilidades = Visibilidad.getNombresVisibilidades();

            //for (int i = 0; i < visibilidades.Count(); i++)
            //{
            //    comboBox3.Items.Add(visibilidades[i]);
            //}

            //TODO: datos de test, borrar despues
            comboBox3.Items.Add("Platino");
            comboBox3.Items.Add("Oro");
            comboBox3.Items.Add("Plata");
            comboBox3.Items.Add("Bronce");
            comboBox3.Items.Add("Gratis");
        }

        private void llenarComboBoxTrimestres()
        {
            comboBox2.Items.Add("Ene-Feb-Mar");
            comboBox2.Items.Add("Abr-May-Jun");
            comboBox2.Items.Add("Jul-Ago-Sep");
            comboBox2.Items.Add("Oct-Nov-Dic");
        }

        private int getNroTrimestre(String trimestre)
        {
            switch (trimestre)
            {
                case "Ene-Feb-Mar":
                    return 1;
                    break;

                case "Abr-May-Jun":
                    return 2;
                    break;

                case "Jul-Ago-Sep":
                    return 3;
                    break;

                case "Oct-Nov-Dic":
                    return 4;
                    break;

                default:
                    throw new Exception("El nombre del trimestre es invalido");
            }
        }

    }
}
