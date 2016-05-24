using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form abmRolPrincipal = new ABM_Rol.Principal();
            abmRolPrincipal.Visible = true;

        }

        private void button3_Click(object sender, EventArgs e)
        {
            Form abmUsuario = new ABM_Usuario.Principal();
            abmUsuario.Visible = true;
        }

    }
}
