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
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.Login
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
        }

        private void limpiarCampos()
        {
            this.limpiarUsername();
            this.limpiarPassword();
        }

        private void limpiarUsername()
        {
            textBox1.Clear();
        }

        private void limpiarPassword()
        {
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
            {
                this.limpiarPassword();
                throw new Exception("El Password debe empezar con un carácter visible.");
            }
        }

        private void loguearse()
        {
            try
            {
                //TODO: descomentar
                this.validarLogin();

                String username = textBox1.Text;
                String password = textBox2.Text;
                //TODO: Dejo hardcodeado usuario admin para tests, sacar despues
                //String username = "admin";
                //String password = "w23e";
                //String username = "odamartínez";
                //String password = "2927009";

                

                SQLManager manager = new SQLManager().generarSP("login")
                                                 .agregarStringSP("@usuario", username)
                                                 .agregarStringSP("@password_ingresada", password);

                manager.ejecutarSP();

                String tipoUsuario = Usuario.getTipoUsuario(username);

                this.validarQueElUsuarioTengaRoles(username);

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
                        if (Usuario.getRolesUsuario(username).Count() > 1)
                        {
                            //TODO: testear
                            this.mostrarSeleccionDeRol(username);
                        }
                        else
                        {
                            MessageBox.Show("El usuario no puede ingresar al sistema ya que no tiene ningún rol.");
                        }
                        
                    }
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

        private void mostrarMenuSegunRol(String username, String rol)
        {
            Form menu = new Menu(username, rol);
            menu.Show();
            this.Hide();
        }

        private void mostrarSeleccionDeRol(String username)
        {
            Form seleccionDeRol = new SeleccionarRol(username,this);
            seleccionDeRol.Show();
            this.Hide();
        }

        private void validarQueElUsuarioTengaRoles(String username)
        {
            if (Dominio.Usuario.getRolesUsuario(username).Count.Equals(0))
                throw new Exception("El usuario no puede iniciar sesión ya que no tiene ningún rol.");
        }

    }
}
