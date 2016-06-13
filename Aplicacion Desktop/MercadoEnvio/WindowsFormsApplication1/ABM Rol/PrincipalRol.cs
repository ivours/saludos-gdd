using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.ABM_Rol
{
    public partial class PrincipalRol : Form
    {

        public PrincipalRol()
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
        }

        private void Form1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form alta = new ABM_Rol.AltaRol();
            alta.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Form bajaRol = new ABM_Rol.BajaRol();
            Form listado = new ABM_Rol.ListadoRoles(bajaRol);
            listado.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Form modificarRol = new ABM_Rol.ModificarRol();
            Form listado = new ABM_Rol.ListadoRoles(modificarRol);
            listado.Show();
        }

    }
}
