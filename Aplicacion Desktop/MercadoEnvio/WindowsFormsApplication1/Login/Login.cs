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
                                                 .agregarStringSP("@password_ingresada", textBox2.Text);

                manager.ejecutarSP();

                //MessageBox.Show("login ok");
                String tipoUsuario = this.getTipoUsuario(textBox1.Text);

                if (tipoUsuario.Equals("Administrador"))
                {
                    //TODO: loguear como admin
                }
                else
                {
                    if (this.getRolesUsuario(textBox1.Text).Count() == 1)
                    {
                        //TODO: ingresar con tipo y unico rol asignado
                    }
                    else
                    {
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

        private String getTipoUsuario(String username)
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getTipoUsuario(@username)";
            consulta.Parameters.Add(new SqlParameter("@username",username));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (String) reader.GetValue(0);
        }

        private List<String> getRolesUsuario(String username)
        {
            List<String> rolesUsuario = new List<String>();
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getRolesUsuario(@username)";
            consulta.Parameters.Add(new SqlParameter(@username, username));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            while (reader.Read())
                rolesUsuario.Add((String) reader.GetValue(0));

            return rolesUsuario;
        }

    }
}
