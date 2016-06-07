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

namespace WindowsFormsApplication1.ABM_Usuario
{
    public partial class ListadoUsuarios : Form
    {
        public ListadoUsuarios()
        {
            InitializeComponent();
            ConfiguradorDataGrid.configurar(dataGridView1);
        }

        private SqlDataReader filtrarUsuarios()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.filtrarUsuarios(@username, @tipo, @habilitado)";
            consulta.Parameters.Add(new SqlParameter("@username", textBox1.Text));
            consulta.Parameters.Add(new SqlParameter("@tipo", this.filtrarTipo()));
            consulta.Parameters.Add(new SqlParameter("@habilitado", this.filtrarHabilitado()));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private String filtrarTipo()
        {
            if (comboBox1.SelectedItem.Equals(null))
                return "";
            else
                return comboBox1.SelectedItem.ToString();
        }

        private String filtrarHabilitado()
        {
            if(comboBox2.SelectedItem.Equals(null))
                return "";
            else
            {
                if(comboBox2.SelectedItem.Equals("SI"))
                {
                    return "1";
                }
                else
                {
                    return "0";
                }
            }

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

        private void limpiarCampos()
        {
            textBox1.Clear();
            comboBox1.SelectedItem = null;
            comboBox2.SelectedItem = null;
            comboBox1.SelectedIndex = -1;
            comboBox2.SelectedIndex = -1;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.filtrarUsuarios(), dataGridView1);
        }
    }
}
