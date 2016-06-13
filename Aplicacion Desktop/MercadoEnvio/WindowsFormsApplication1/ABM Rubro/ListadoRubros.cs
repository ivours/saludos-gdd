using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.ABM_Rubro
{
    public partial class ListadoRubros : Form
    {
        Form formAnterior;

        public ListadoRubros(Form formAnterior)
        {
            InitializeComponent();
            this.inicializarCampos();
            this.formAnterior = formAnterior;
        }

        private void inicializarCampos()
        {
            ConfiguradorDataGrid.configurar(dataGridView1);
        }

        private SqlDataReader getRubros()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getRubros(@nombreRubro, @descripcion)";
            consulta.Parameters.Add(new SqlParameter("@nombreRubro", this.filtrarNombreRubro()));
            consulta.Parameters.Add(new SqlParameter("@descripcion", this.filtrarDescripcion()));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private Object filtrarNombreRubro()
        {
            if (textBox1.Text.Length.Equals(0))
                return DBNull.Value;
            else
                return textBox1.Text;
        }

        private Object filtrarDescripcion()
        {
            if (textBox1.Text.Length.Equals(0))
                return DBNull.Value;
            else
                return textBox2.Text;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.getRubros(), dataGridView1);
        }

        private void button4_Click(object sender, EventArgs e)
        {
            String nombreRubro;

            switch (formAnterior.Name)
            {
                case "ListadoEstadistico":
                    nombreRubro = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                    (formAnterior as Listado_Estadistico.ListadoEstadistico).setRubro(nombreRubro);
                    break;

                case "CargarDatosEmpresa":
                    nombreRubro = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                    (formAnterior as ABM_Usuario.CargarDatosEmpresa).setRubroPrincipal(nombreRubro);
                    break;

                case "ModificarDatosEmpresa":
                    nombreRubro = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                    (formAnterior as ABM_Usuario.ModificarDatosEmpresa).setRubroPrincipal(nombreRubro);
                    break;

                case "CrearPublicacion":
                    nombreRubro = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                    (formAnterior as Generar_Publicación.CrearPublicacion).setRubro(nombreRubro);
                    break;

                case "ListadoPublicaciones":
                    nombreRubro = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                    (formAnterior as ComprarOfertar.ListadoPublicaciones).addRubro(nombreRubro);
                    break;

            }

            this.Close();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

        private void limpiarCampos()
        {
            textBox1.Clear();
            textBox2.Clear();
            dataGridView1.DataSource = null;
            dataGridView1.Refresh();
        }

    }
}
