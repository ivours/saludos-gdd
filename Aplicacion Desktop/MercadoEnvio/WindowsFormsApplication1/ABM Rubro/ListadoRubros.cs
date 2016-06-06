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
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.getRubros(), dataGridView1);
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

        }

        private void button4_Click(object sender, EventArgs e)
        {
            String rubro;

            switch (formAnterior.Name)
            {
                case "ListadoEstadistico":
                    rubro = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                    (formAnterior as Listado_Estadistico.ListadoEstadistico).setRubro(rubro);
                    break;
            }

            this.Close();
        }

    }
}
