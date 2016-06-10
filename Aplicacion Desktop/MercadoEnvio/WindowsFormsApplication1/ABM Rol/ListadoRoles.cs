using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.ABM_Rol
{
    public partial class ListadoRoles : Form
    {
        Form formAnterior;

        public ListadoRoles(Form formAnterior)
        {
            InitializeComponent();
            ConfiguradorDataGrid.configurar(dataGridView1);
            this.formAnterior = formAnterior;
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.getRoles(), dataGridView1);
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
        }

        //TODO: agregar filtros
        private SqlDataReader getRoles()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.ROLES";
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
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
                    idRol = (int) dataGridView1.SelectedRows[0].Cells[0].Value;
                    nombreRol = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                    (formAnterior as ABM_Usuario.CargarDatosUsuario).setRol(nombreRol,idRol);
                    break;

                case "BajaRol":
                    idRol = (int) dataGridView1.SelectedRows[0].Cells[0].Value;
                    nombreRol = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                    (formAnterior as ABM_Rol.BajaRol).bajaRol(idRol);
                    MessageBox.Show("Se ha eliminado el rol '" + nombreRol + "'");
                    ConfiguradorDataGrid.llenarDataGridConConsulta(this.getRoles(), dataGridView1);
                    break;

                case "ModificarRol":
                    idRol = (int) dataGridView1.SelectedRows[0].Cells[0].Value;
                    nombreRol = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                    (formAnterior as ABM_Rol.ModificarRol).setIdRol(idRol);
                    (formAnterior as ABM_Rol.ModificarRol).setNombreRol(nombreRol);
                    (formAnterior as ABM_Rol.ModificarRol).setFuncionalidades();
                    formAnterior.Show();
                    break;
                }

            this.Close();
        }
    }
}
