using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.Generar_Publicación
{
    public partial class Principal : Form
    {
        String username;

        public Principal(String username)
        {
            InitializeComponent();
            this.username = username;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Generar_Publicación.CrearPublicacion crearPublicacion = new CrearPublicacion(username);
            crearPublicacion.Show();
            this.Close();
        }
    }
}
