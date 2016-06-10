using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication1.ABM_Usuario
{
    public partial class HabilitarDeshabilitar : Form
    {
        String username;
        int habilitado;

        public HabilitarDeshabilitar()
        {
            InitializeComponent();
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
            SQLManager manager = new SQLManager().generarSP("borrarUsuario")
            .agregarStringSP("@username", this.username);

            manager.ejecutarSP();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (comboBox1.SelectedItem.Equals("NO"))
                this.deshabilitarUsuario();
            else if (comboBox1.SelectedItem.Equals("SI"))
                this.habilitarUsuario();

            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
