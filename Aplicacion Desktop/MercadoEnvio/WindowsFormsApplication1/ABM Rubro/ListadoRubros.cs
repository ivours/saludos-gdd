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
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.getRubros(), dataGridView1); //TODO: esto ponerlo en el click de buscar
        }

        private void inicializarCampos()
        {
            ConfiguradorDataGrid.configurar(dataGridView1);
        }

        //TODO: agregar filtros
        private SqlDataReader getRubros()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.RUBROS";
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            dataGridView1.AutoResizeColumns();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            String nombreRubro;
            int idRubro;

            switch (formAnterior.Name)
            {
                case "ListadoEstadistico":
                    nombreRubro = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                    (formAnterior as Listado_Estadistico.ListadoEstadistico).setRubro(nombreRubro);
                    break;

                case "CargarDatosEmpresa":
                    idRubro = (int) dataGridView1.SelectedRows[0].Cells[0].Value;
                    nombreRubro = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                    (formAnterior as ABM_Usuario.CargarDatosEmpresa).setRubroPrincipal(nombreRubro, idRubro);
                    break;

            }

            this.Close();
        }

    }
}
