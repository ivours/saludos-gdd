using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication1.Cambio_de_Password
{
    public partial class CambiarPassword : Form
    {
        String username;

        public CambiarPassword(String username)
        {
            InitializeComponent();
            this.username = username;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                this.validarPasswordNueva();
                this.cambiarPassword();
            }
            catch (Exception excepcion)
            {
                MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
                this.limpiarCampos();
            }

        }

        private void validarPasswordNueva()
        {
            if (!textBox2.Text.Equals(textBox3.Text))
                throw new Exception("La password nueva no coincide");
        }

        private void limpiarCampos()
        {
            textBox1.Clear();
            textBox2.Clear();
            textBox3.Clear();
        }

        private void cambiarPassword()
        {
            SQLManager manager = new SQLManager().generarSP("cambiarPassword")
                 .agregarStringSP("@usuario", username)
                 .agregarStringSP("@passwordIngresada", textBox1.Text)
                 .agregarStringSP("@passwordNueva", textBox2.Text);

            manager.ejecutarSP();
        }

    }
}
