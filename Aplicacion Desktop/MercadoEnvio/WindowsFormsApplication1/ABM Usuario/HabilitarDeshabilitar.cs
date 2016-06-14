using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.ABM_Usuario
{
    public partial class HabilitarDeshabilitar : Form
    {
        String usuarioLogueado;
        String username;
        int habilitado;

        public HabilitarDeshabilitar(String usuarioLogueado)
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
            this.usuarioLogueado = usuarioLogueado;
            this.llenarComboBox();
        }

        private void llenarComboBox()
        {
            comboBox1.Items.Add("SI");
            comboBox1.Items.Add("NO");
        }

        public void setUsername(String username)
        {
            this.username = username;
        }

        public void setHabilitado(int habilitado)
        {
            this.habilitado = habilitado;
            this.inicializarComboBox(habilitado);
        }

        private void inicializarComboBox(int habilitado)
        {
            switch (habilitado)
            {
                case 0:
                    comboBox1.SelectedIndex = 1;
                    comboBox1.SelectedItem = "NO";
                    break;

                case 1:
                    comboBox1.SelectedIndex = 0;
                    comboBox1.SelectedItem = "SI";
                    break;
            }
        }

        private void habilitarUsuario()
        {
            SQLManager manager = new SQLManager().generarSP("habilitarUsuario")
                     .agregarStringSP("@username", this.username);

            manager.ejecutarSP();
        }

        private void deshabilitarUsuario()
        {

            try
            {
                this.validarQueElUsuarioADeshabilitarNoSeaElUsuarioLogueado();

                SQLManager manager = new SQLManager().generarSP("borrarUsuario")
                .agregarStringSP("@username", this.username);

                manager.ejecutarSP();
            }
            catch (Exception excepcion)
            {
                MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
            }
 
        }

        private void validarQueElUsuarioADeshabilitarNoSeaElUsuarioLogueado()
        {
            if(this.username.Equals(this.usuarioLogueado))
                throw new Exception("Un usuario no se puede deshabilitar a sí mismo.");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (comboBox1.SelectedItem.Equals("NO"))
            {
                this.deshabilitarUsuario();
                MessageBox.Show("Usuario deshabilitado exitosamente.");
            }
            else if (comboBox1.SelectedItem.Equals("SI"))
            {
                this.habilitarUsuario();
                MessageBox.Show("Usuario habilitado exitosamente.");
            }

            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
