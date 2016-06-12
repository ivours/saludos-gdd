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
        Form formAnterior;

        public ListadoUsuarios(Form formAnterior)
        {
            InitializeComponent();
            this.formAnterior = formAnterior;
            ConfiguradorDataGrid.configurar(dataGridView1);
            this.llenarComboBoxTipoDeUsuario();
            this.llenarComboBoxHabilitado();
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
        }

        private SqlDataReader getUsuarios()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getUsuarios(@username, @tipo, @habilitado)";
            consulta.Parameters.Add(new SqlParameter("@username", this.filtrarUsername()));
            consulta.Parameters.Add(new SqlParameter("@tipo", this.filtrarTipo()));
            consulta.Parameters.Add(new SqlParameter("@habilitado", this.filtrarHabilitado()));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            
            return reader;
        }

        //TODO: ver si el filtro tiene que ser exacto o like
        private Object filtrarUsername()
        {
            if (textBox1.Text.Length.Equals(0))
                return DBNull.Value;
            else
                return textBox1.Text;
        }

        private Object filtrarTipo()
        {
            if (comboBox1.SelectedIndex.Equals(-1))
                return DBNull.Value;
            else
                return comboBox1.SelectedItem.ToString();
        }

        private Object filtrarHabilitado()
        {
            if (comboBox2.SelectedIndex.Equals(-1))
                return DBNull.Value;
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
            dataGridView1.DataSource = null;
            dataGridView1.Refresh();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.getUsuarios(), dataGridView1);
        }

        private void llenarComboBoxTipoDeUsuario()
        {
            comboBox1.Items.Add("Administrador");
            comboBox1.Items.Add("Cliente");
            comboBox1.Items.Add("Empresa");
        }

        private void llenarComboBoxHabilitado()
        {
            comboBox2.Items.Add("SI");
            comboBox2.Items.Add("NO");
        }

        private void button5_Click(object sender, EventArgs e)
        {
            String usernameSeleccionado = dataGridView1.SelectedRows[0].Cells[0].Value.ToString();
            int habilitado = Convert.ToInt32(dataGridView1.SelectedRows[0].Cells[2].Value);

            switch (formAnterior.Name)
            {
                case "CambiarPassword":
                    (formAnterior as Cambio_de_Password.CambiarPassword).setUsername(usernameSeleccionado);
                    formAnterior.Show();
                    break;

                case "HabilitarDeshabilitar":
                    (formAnterior as ABM_Usuario.HabilitarDeshabilitar).setUsername(usernameSeleccionado);
                    (formAnterior as ABM_Usuario.HabilitarDeshabilitar).setHabilitado(habilitado);
                    formAnterior.Show();
                    break;
            }

            this.Close();
        }
    }
}
