using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.ABM_Visibilidad
{
    public partial class PrincipalVisibilidad : Form
    {
        public PrincipalVisibilidad()
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ABM_Visibilidad.AltaVisibilidad altaVisibilidad = new AltaVisibilidad();
            altaVisibilidad.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            ABM_Visibilidad.BajaVisibilidad bajaVisibilidad = new BajaVisibilidad();
            ABM_Visibilidad.ListadoVisibilidades listadoVisibilidades = new ListadoVisibilidades(bajaVisibilidad);
            listadoVisibilidades.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            ABM_Visibilidad.ModificarVisibilidad modificarVisibilidad = new ModificarVisibilidad();
            ABM_Visibilidad.ListadoVisibilidades listadoVisibilidades = new ListadoVisibilidades(modificarVisibilidad);
            listadoVisibilidades.Show();
        }
    }
}
