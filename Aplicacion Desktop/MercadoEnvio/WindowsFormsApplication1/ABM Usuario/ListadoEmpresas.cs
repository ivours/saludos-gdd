using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.ABM_Usuario
{
    public partial class ListadoEmpresas : Form
    {
        public ListadoEmpresas()
        {
            InitializeComponent();
            ConfiguradorDataGrid.configurar(dataGridView1);
        }

        private void limpiarCampos()
        {
            textBox1.Clear();
            textBox2.Clear();
            textBox3.Clear();
            dataGridView1.DataSource = null;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        //TODO: Estos filtros los valido?
        private SqlDataReader filtrarEmpresas()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.filtrarEmpresas(@razon_social, @cuit, @mail)";
            consulta.Parameters.Add(new SqlParameter("@razon_social", textBox1.Text));
            consulta.Parameters.Add(new SqlParameter("@cuit", textBox2.Text));
            consulta.Parameters.Add(new SqlParameter("@mail", textBox3.Text));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.filtrarEmpresas(), dataGridView1);
        }

        private void seleccionarEmpresaAModificar()
        {
            if (dataGridView1.DataSource.Equals(null))
                throw new Exception("Debe seleccionar una empresa a modificar");

            ABM_Usuario.ModificarDatosEmpresa modificarDatosEmpresa = new ModificarDatosEmpresa();

            String razonSocial = dataGridView1.SelectedRows[0].Cells[0].Value.ToString();
            String cuit = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
            String email = dataGridView1.SelectedRows[0].Cells[2].Value.ToString();
            String telefono = dataGridView1.SelectedRows[0].Cells[3].Value.ToString();
            String calle = dataGridView1.SelectedRows[0].Cells[4].Value.ToString();
            String nroCalle = dataGridView1.SelectedRows[0].Cells[5].Value.ToString();
            decimal piso = Convert.ToDecimal(dataGridView1.SelectedRows[0].Cells[6].Value);
            String depto = dataGridView1.SelectedRows[0].Cells[7].Value.ToString();
            String ciudad = dataGridView1.SelectedRows[0].Cells[8].Value.ToString();
            String nombreDeContacto = dataGridView1.SelectedRows[0].Cells[9].Value.ToString();
            String codigoPostal = dataGridView1.SelectedRows[0].Cells[10].Value.ToString();
            String localidad = dataGridView1.SelectedRows[0].Cells[11].Value.ToString();
            String rubro = dataGridView1.SelectedRows[0].Cells[12].Value.ToString();

            modificarDatosEmpresa.setRazonSocial(razonSocial);
            modificarDatosEmpresa.setCuit(cuit);
            modificarDatosEmpresa.setEmail(email);
            modificarDatosEmpresa.setTelefono(telefono);
            modificarDatosEmpresa.setCalle(calle);
            modificarDatosEmpresa.setNroCalle(nroCalle);
            modificarDatosEmpresa.setPiso(piso);
            modificarDatosEmpresa.setCiudad(ciudad);
            modificarDatosEmpresa.setNombreDeContacto(nombreDeContacto);
            modificarDatosEmpresa.setCodigoPostal(codigoPostal);
            modificarDatosEmpresa.setLocalidad(localidad);
            modificarDatosEmpresa.setRubroPrincipal(rubro);

            modificarDatosEmpresa.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                this.seleccionarEmpresaAModificar();
            }
            catch (Exception excepcion)
            {
                MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
            }
        }
    }
}
