using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.Login
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void limpiarCampos()
        {
            textBox1.Clear();
            textBox2.Clear();
        }

        private void validarLogin()
        {
            this.validarUsername();
            this.validarPassword();
        }

        private void validarUsername()
        {
            if (!Validacion.empiezaConCaracter(textBox1.Text))
                throw new Exception("El Username debe empezar con un carácter visible.");
        }

        private void validarPassword()
        {
            if (!Validacion.empiezaConCaracter(textBox2.Text))
                throw new Exception("El Password debe empezar con un carácter visible.");
        }

        private void loguearse()
        {
            try
            {
                this.validarLogin();

                SQLManager manager = new SQLManager().generarSP("login")
                                                 .agregarStringSP("@usuario", textBox1.Text)
                                                 .agregarStringSP("@password_ingresada", Encriptador.encriptarSegunSHA256(textBox2.Text));

                try
                {
                    manager.ejecutarSP();
                    MessageBox.Show("login ok");

                }
                catch (Exception e)
                {
                    MessageBox.Show(e.Message, "Error", MessageBoxButtons.OK);
                }

            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message, "Error", MessageBoxButtons.OK);
            }

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.loguearse();
        }



    }
}
