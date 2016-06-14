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

namespace WindowsFormsApplication1.ABM_Usuario
{
    public partial class ListadoClientes : Form
    {
        public ListadoClientes()
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
            ConfiguradorDataGrid.configurar(dataGridView1);
        }

        private void limpiarCampos()
        {
            textBox1.Clear();
            textBox2.Clear();
            textBox3.Clear();
            textBox4.Clear();
            dataGridView1.DataSource = null;
        }

        private SqlDataReader filtrarClientes()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.filtrarClientes(@nombre, @apellido, @nro_documento, @mail)";
            consulta.Parameters.Add(new SqlParameter("@nombre", textBox1.Text));
            consulta.Parameters.Add(new SqlParameter("@apellido", textBox2.Text));
            consulta.Parameters.Add(new SqlParameter("@nro_documento", textBox3.Text));
            consulta.Parameters.Add(new SqlParameter("@mail", textBox4.Text));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.filtrarClientes(), dataGridView1);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void seleccionarClienteAModificar()
        {
                ABM_Usuario.ModificarDatosCliente modificarDatosCliente = new ModificarDatosCliente();

                String nombre = dataGridView1.SelectedRows[0].Cells[0].Value.ToString();
                String apellido = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                String telefono = dataGridView1.SelectedRows[0].Cells[2].Value.ToString();
                String calle = dataGridView1.SelectedRows[0].Cells[3].Value.ToString();
                String nroCalle = dataGridView1.SelectedRows[0].Cells[4].Value.ToString();
                DateTime fechaDeNacimiento = Convert.ToDateTime(dataGridView1.SelectedRows[0].Cells[5].Value);
                String codigoPostal = dataGridView1.SelectedRows[0].Cells[6].Value.ToString();
                String depto = dataGridView1.SelectedRows[0].Cells[7].Value.ToString();
                decimal piso = Convert.ToDecimal(dataGridView1.SelectedRows[0].Cells[8].Value);
                String localidad = dataGridView1.SelectedRows[0].Cells[9].Value.ToString();
                String nroDeDocumento = dataGridView1.SelectedRows[0].Cells[10].Value.ToString();
                String tipoDeDocumento = dataGridView1.SelectedRows[0].Cells[11].Value.ToString();
                String email = dataGridView1.SelectedRows[0].Cells[12].Value.ToString();

                modificarDatosCliente.setNombre(nombre);
                modificarDatosCliente.setApellido(apellido);
                modificarDatosCliente.setNroDeDocumento(nroDeDocumento);
                modificarDatosCliente.setTipoDeDocumento(tipoDeDocumento);
                modificarDatosCliente.setFechaDeNacimiento(fechaDeNacimiento);
                modificarDatosCliente.setEmail(email);
                modificarDatosCliente.setTelefono(telefono);
                modificarDatosCliente.setCalle(calle);
                modificarDatosCliente.setNroCalle(nroCalle);
                modificarDatosCliente.setPiso(piso);
                modificarDatosCliente.setDepto(depto);
                modificarDatosCliente.setLocalidad(localidad);
                modificarDatosCliente.setCodigoPostal(codigoPostal);

                modificarDatosCliente.Show();

        }

        private void button4_Click(object sender, EventArgs e)
        {

            if (dataGridView1.SelectedRows.Count > 0)
            {
                try
                {
                    this.seleccionarClienteAModificar();
                    this.Close();
                }
                catch (Exception excepcion)
                {
                    MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
                }
            }

        }

    }

}
