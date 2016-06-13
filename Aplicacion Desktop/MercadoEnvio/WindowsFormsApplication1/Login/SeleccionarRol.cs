using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Dominio;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.Login
{
    public partial class SeleccionarRol : Form
    {
        String username;
        Login formLogin;

        public SeleccionarRol(String username, Login formLogin)
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
            this.username = username;
            this.llenarComboBoxConRoles();
            this.formLogin = formLogin;
        }

        private void llenarComboBoxConRoles()
        {
            List<String> roles = Usuario.getRolesUsuario(username);

            for (int i = 0; i < roles.Count(); i++)
            {
                comboBox1.Items.Add(roles[i]);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.mostrarMenuSegunRol(username, (String) comboBox1.SelectedItem);
        }

        private void mostrarMenuSegunRol(String username, String rol)
        {
            Form menu = new Menu(username, rol);
            this.Hide();
            menu.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            formLogin.Show();
            this.Close();
        }
    }
}
