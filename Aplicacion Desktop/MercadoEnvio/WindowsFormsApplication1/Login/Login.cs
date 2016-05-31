using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Dominio;

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

                String username = textBox1.Text;
                String password = textBox2.Text;

                SQLManager manager = new SQLManager().generarSP("login")
                                                 .agregarStringSP("@usuario", username)
                                                 .agregarStringSP("@password_ingresada", password);

                manager.ejecutarSP();

                String tipoUsuario = Usuario.getTipoUsuario(username);
                Form menu;

                if (tipoUsuario.Equals("Administrador"))
                {
                    //Se ingresa como administrador
                    this.mostrarMenuSegunRol(username, "Administrador");
                }
                else
                {
                    if (Usuario.getRolesUsuario(username).Count().Equals(1))
                    {
                        //Se ingresa con tipo y unico rol asignado
                        String rol = Usuario.getRolesUsuario(username)[0];
                        this.mostrarMenuSegunRol(username, rol);
                    }
                    else
                    {
                        MessageBox.Show("chau");
                        //TODO: proceder a ventana de seleccion de rol
                    }
                }


            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message, "Error", MessageBoxButtons.OK);
                this.limpiarCampos();
            }

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.loguearse();
        }

        private void mostrarMenuSegunRol(String username, String rol)
        {
            Form menu = new Menu(username, rol);
            menu.Visible = true;
        }

    }
}
