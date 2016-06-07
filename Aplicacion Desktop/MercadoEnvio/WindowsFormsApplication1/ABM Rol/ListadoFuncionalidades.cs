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

namespace WindowsFormsApplication1.ABM_Rol
{
    public partial class ListadoFuncionalidades : Form
    {
        Form formAnterior;

        public ListadoFuncionalidades(Form formAnterior)
        {
            InitializeComponent();
            this.formAnterior = formAnterior;
            ConfiguradorDataGrid.configurar(dataGridView1);
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.getFuncionalidades(), dataGridView1);
        }

        //TODO: agregar filtros
        private SqlDataReader getFuncionalidades()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.FUNCIONALIDADES";
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            String nombreFuncionalidad;

            switch (formAnterior.Name)
            {
                case "AltaRol":
                    nombreFuncionalidad = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                    (formAnterior as ABM_Rol.AltaRol).addFuncionalidad(nombreFuncionalidad);
                    break;
            }

            this.Close();
        }


    }
}
