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
            this.inicializarCampos();

        }

        private void inicializarCampos()
        {
            comboBox1.SelectedIndexChanged += OnSelectedIndexChanged;
            comboBox1.SelectedIndex = 0;
            comboBox2.SelectedIndex = 0;
            comboBox3.SelectedIndex = 0;
            textBox1.Text = "";
            numericUpDown1.Value = 2015;
            dataGridView1.DataSource = null;
            dataGridView1.Rows.Clear();
            dataGridView1.Refresh();
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
            try
            {
                this.validarFiltros();

                switch (comboBox1.SelectedIndex)
                {
                    case 0:
                        this.llenarDataGridConConsulta(this.vendedoresConMayorCantidadDeProductosNoVendidos());
                        break;

                    case 1:
                        this.llenarDataGridConConsulta(this.clientesMasCompradoresEnUnRubro());
                        break;

                    case 2:
                        this.llenarDataGridConConsulta(this.vendedoresConMasFacturas());
                        break;

                    case 3:
                        this.llenarDataGridConConsulta(this.vendedoresConMayorFacturacion());
                        dataGridView1.Columns[1].HeaderText = dataGridView1.Columns[1].HeaderText + " (ARS)";
                        break;
                }
            }
            catch(Exception exception)
            {
                MessageBox.Show(exception.Message, "Error", MessageBoxButtons.OK);
            }
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
            consulta.Parameters.Add(new SqlParameter("@anio", numericUpDown1.Value));
            consulta.Parameters.Add(new SqlParameter("@trimestre", Fecha.getNroTrimestreDesdeTrimestre(comboBox2.SelectedItem.ToString())));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private SqlDataReader clientesMasCompradoresEnUnRubro()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.clientesMasCompradoresEnUnRubro(@anio, @trimestre, @rubro)";
            consulta.Parameters.Add(new SqlParameter("@anio", numericUpDown1.Value));
            consulta.Parameters.Add(new SqlParameter("@trimestre", Fecha.getNroTrimestreDesdeTrimestre(comboBox2.SelectedItem.ToString())));
            consulta.Parameters.Add(new SqlParameter("@rubro", textBox1.Text));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private SqlDataReader vendedoresConMayorFacturacion()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.vendedoresConMayorFacturacion(@anio, @trimestre)";
            consulta.Parameters.Add(new SqlParameter("@anio", numericUpDown1.Value));
            consulta.Parameters.Add(new SqlParameter("@trimestre", Fecha.getNroTrimestreDesdeTrimestre(comboBox2.SelectedItem.ToString())));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private SqlDataReader vendedoresConMayorCantidadDeProductosNoVendidos()
        {
            //TODO: ver si el nombre de parametro visibilidad esta bien

            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.vendedoresConMayorCantidadDeProductosNoVendidos(@anio, @trimestre, @visibilidad)";
            consulta.Parameters.Add(new SqlParameter("@anio", numericUpDown1.Value));
            consulta.Parameters.Add(new SqlParameter("@trimestre", Fecha.getNroTrimestreDesdeTrimestre(comboBox2.SelectedItem.ToString())));
            consulta.Parameters.Add(new SqlParameter("@visibilidad", comboBox3.SelectedValue));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private void OnSelectedIndexChanged(object sender, EventArgs e)
        {
            textBox1.Hide();
            label4.Hide();
            label5.Hide();
            comboBox3.Hide();
            button3.Hide();
            button4.Hide();

            switch (comboBox1.SelectedItem.ToString())
            {
                case "Vendedores con mayor cantidad de productos no vendidos":
                    label4.Show();
                    comboBox3.Show();
                    button4.Show();
                    break;

                case "Clientes con mayor cantidad de productos comprados":
                    textBox1.Show();
                    label5.Show();
                    button3.Show();
                    break;
            }

        }

        private void llenarComboBoxVisibilidades()
        {
            List<String> visibilidades = Visibilidad.getNombresVisibilidades();

            for (int i = 0; i < visibilidades.Count(); i++)
            {
                comboBox3.Items.Add(visibilidades[i]);
            }

            //TODO: datos de test, borrar despues
            //comboBox3.Items.Add("Platino");
            //comboBox3.Items.Add("Oro");
            //comboBox3.Items.Add("Plata");
            //comboBox3.Items.Add("Bronce");
            //comboBox3.Items.Add("Gratis");
        }

        private void llenarComboBoxTrimestres()
        {
            comboBox2.Items.Add("Ene-Feb-Mar");
            comboBox2.Items.Add("Abr-May-Jun");
            comboBox2.Items.Add("Jul-Ago-Sep");
            comboBox2.Items.Add("Oct-Nov-Dic");
        }

        public void setRubro(String rubro)
        {
            textBox1.Text = rubro;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            ABM_Rubro.ListadoRubros listadoRubros = new ABM_Rubro.ListadoRubros(this);
            listadoRubros.Show();
        }

        private void validarFiltros()
        {
            if (comboBox2.SelectedItem.Equals(null))
                throw new Exception("Debe seleccionar un trimestre");
            else
                if ( (!Validacion.esTrimestreMenorAlActual(Fecha.getNroTrimestreDesdeTrimestre(comboBox2.SelectedItem.ToString()))) && 
                    (Fecha.esAnioActual(numericUpDown1.Value)) )
                    throw new Exception("Debe seleccionar un trimestre anterior al trimestre en curso");


            if (comboBox1.SelectedItem.Equals(null))
                throw new Exception("Debe seleccionar una estadística");

            if (comboBox1.SelectedItem.Equals("Vendedores con mayor cantidad de productos no vendidos") && (comboBox3.SelectedItem.Equals(null)))
                throw new Exception("Debe seleccionar una visibilidad");

            if (comboBox1.SelectedItem.Equals("Clientes con mayor cantidad de productos comprados") && textBox1.Text.Equals(""))
                throw new Exception("Debe seleccionar un rubro");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.inicializarCampos();
        }

    }
}
