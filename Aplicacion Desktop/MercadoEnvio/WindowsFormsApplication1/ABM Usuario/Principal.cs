using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.ABM_Usuario
{
    public partial class Principal : Form
    {
        String username;

        public Principal(String username)
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
            this.username = username;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form altaUsuario = new ABM_Usuario.CargarDatosUsuario();
            this.abrirVentana(altaUsuario);
        }

        private void abrirVentana(Form siguienteFormulario)
        {
            siguienteFormulario.Visible = true;
            this.Visible = false;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            ABM_Usuario.ListadoClientes listadoClientes = new ABM_Usuario.ListadoClientes();
            listadoClientes.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            ABM_Usuario.ListadoEmpresas listadoEmpresas = new ABM_Usuario.ListadoEmpresas();
            listadoEmpresas.Show();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            Cambio_de_Password.CambiarPassword cambiarPassword = new Cambio_de_Password.CambiarPassword("Administrador");
            ABM_Usuario.ListadoUsuarios listadoUsuarios = new ABM_Usuario.ListadoUsuarios(cambiarPassword);
            listadoUsuarios.Show();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            ABM_Usuario.HabilitarDeshabilitar habilitarDeshabilitar = new HabilitarDeshabilitar(this.username);
            ABM_Usuario.ListadoUsuarios listadoUsuarios = new ABM_Usuario.ListadoUsuarios(habilitarDeshabilitar);
            listadoUsuarios.Show();
        }
    }
}
