using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.Generar_Publicación
{
    public partial class ListadoPublicaciones : Form
    {
        Form formAnterior;
        String username;

        public ListadoPublicaciones(Form formAnterior, String username)
        {
            InitializeComponent();
            ConfiguradorDataGrid.configurar(dataGridView1);
            this.formAnterior = formAnterior;
            this.username = username;
            this.llenarComboBoxEstados();
        }

        private SqlDataReader filtrarPublicacionesParaCambioDeEstado()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.filtrarPublicacionesParaCambioDeEstado(@descripcion, @creador, @estado)";
            consulta.Parameters.Add(new SqlParameter("@descripcion",textBox1.Text));
            consulta.Parameters.Add(new SqlParameter("@creador", textBox2.Text));
            consulta.Parameters.Add(new SqlParameter("@estado", this.filtrarEstado()));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        //Si el usuario es un cliente o una empresa, el filtro de usuario lo pone en readOnly y con el nombre del usuario actual
        //Esto se hace para evitar que un usuario no administrador no pueda cambiarle el estado a publicaciones de otros usuarios
        private void inicializarTextBoxUsuario()
        {
            if (!Dominio.Usuario.getTipoUsuario(username).Equals("Administrador"))
            {
                textBox2.Text = username;
                textBox2.ReadOnly = true;
            }
        }

        private void llenarComboBoxEstados()
        {
            comboBox1.Items.Add("Borrador");
            comboBox1.Items.Add("Activa");
            comboBox1.Items.Add("Pausada");
            comboBox1.Items.Add("Finalizada");
        }

        private String filtrarEstado()
        {
            //TODO: chequear esto
            if (comboBox1.SelectedIndex.Equals(-1))
                return "";
            else
                return comboBox1.SelectedItem.ToString();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            int codigoPublicacion;
            String estadoActual;

            switch (formAnterior.Name)
            {
                case "CambiarEstadoPublicacion":
                    codigoPublicacion = (int) dataGridView1.SelectedRows[0].Cells[0].Value;
                    estadoActual = dataGridView1.SelectedRows[0].Cells[3].Value.ToString();
                    (formAnterior as Generar_Publicación.CambiarEstadoPublicacion).setCodigoPublicacion(codigoPublicacion);
                    (formAnterior as Generar_Publicación.CambiarEstadoPublicacion).setEstadoActual(estadoActual);
                    break;
            }

            formAnterior.Show();
            this.Close();
        }

        private void limpiarCampos()
        {
            textBox1.Clear();
            textBox2.Clear();
            comboBox1.SelectedIndex = -1;
            comboBox1.SelectedItem = null;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.filtrarPublicacionesParaCambioDeEstado(), dataGridView1);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
