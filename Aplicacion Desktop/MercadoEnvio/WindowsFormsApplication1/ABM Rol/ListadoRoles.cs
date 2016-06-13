using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.ABM_Rol
{
    public partial class ListadoRoles : Form
    {
        Form formAnterior;

        public ListadoRoles(Form formAnterior)
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
            ConfiguradorDataGrid.configurar(dataGridView1);
            this.formAnterior = formAnterior;
            this.inicializarComboBoxHabilitado();
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
        }

        private void inicializarComboBoxHabilitado()
        {
            comboBox1.Items.Add("SI");
            comboBox1.Items.Add("NO");

            if (formAnterior.Name.Equals("BajaRol"))
            {
                comboBox1.SelectedIndex = 0;
                comboBox1.Enabled = false;
            }
        }

        private SqlDataReader getRoles()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getRoles(@nombreRol, @habilitado)";
            consulta.Parameters.Add(new SqlParameter("@nombreRol", this.fitrarNombre()));
            consulta.Parameters.Add(new SqlParameter("@habilitado", this.filtrarHabilitado()));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private Object fitrarNombre()
        {
            if (textBox1.Text.Length.Equals(0))
                return DBNull.Value;
            else
                return textBox1.Text;
        }

        private Object filtrarHabilitado()
        {

            if (comboBox1.SelectedIndex.Equals(-1))
            {
                return DBNull.Value;
            }
            else
            {
                if (comboBox1.SelectedItem.ToString().Equals("SI"))
                    return 1;
                else if (comboBox1.SelectedItem.ToString().Equals("NO"))
                    return 0;
                else
                    return DBNull.Value;
            }

        }

        private void Listado_Load(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            String nombreRol;
            int idRol;

            switch (formAnterior.Name)
            {
                case "CargarDatosUsuario":
                    if (dataGridView1.SelectedRows.Count > 0)
                    {
                        idRol = (int)dataGridView1.SelectedRows[0].Cells[0].Value;
                        nombreRol = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                        (formAnterior as ABM_Usuario.CargarDatosUsuario).setRol(nombreRol, idRol);
                        this.Close();
                    }

                    break;

                case "BajaRol":

                    if (dataGridView1.SelectedRows.Count > 0)
                    {
                        idRol = (int)dataGridView1.SelectedRows[0].Cells[0].Value;
                        nombreRol = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                        (formAnterior as ABM_Rol.BajaRol).bajaRol(idRol);
                        (formAnterior as ABM_Rol.BajaRol).borrarRol(idRol);
                        MessageBox.Show("Se ha eliminado el rol '" + nombreRol + "'");
                        ConfiguradorDataGrid.llenarDataGridConConsulta(this.getRoles(), dataGridView1);
                    }
                    
                    break;

                case "ModificarRol":

                    if (dataGridView1.SelectedRows.Count > 0)
                    {
                        idRol = (int)dataGridView1.SelectedRows[0].Cells[0].Value;
                        nombreRol = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                        (formAnterior as ABM_Rol.ModificarRol).setIdRol(idRol);
                        (formAnterior as ABM_Rol.ModificarRol).setNombreRol(nombreRol);
                        (formAnterior as ABM_Rol.ModificarRol).setFuncionalidades();
                        formAnterior.Show();
                        this.Close();
                    }

                    break;
                }
            
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.getRoles(), dataGridView1);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

        private void limpiarCampos()
        {
            textBox1.Clear();
            comboBox1.SelectedIndex = -1;
            comboBox1.SelectedItem = null;
            comboBox1.SelectedValue = null;
            dataGridView1.DataSource = null;
            dataGridView1.Refresh();
        }
    }
}
