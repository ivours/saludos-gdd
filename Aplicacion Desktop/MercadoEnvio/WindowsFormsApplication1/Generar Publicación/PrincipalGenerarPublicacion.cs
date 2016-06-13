using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.Generar_Publicación
{
    public partial class PrincipalGenerarPublicacion : Form
    {
        String username;

        public PrincipalGenerarPublicacion(String username)
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
            this.username = username;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Generar_Publicación.CrearPublicacion crearPublicacion = new CrearPublicacion(username);
            crearPublicacion.Show();
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Generar_Publicación.CambiarEstadoPublicacion cambiarEstadoPublicacion = new CambiarEstadoPublicacion();
            Generar_Publicación.ListadoPublicaciones listadoPublicaciones = new ListadoPublicaciones(cambiarEstadoPublicacion, username);
            listadoPublicaciones.Show();
        }
    }
}
