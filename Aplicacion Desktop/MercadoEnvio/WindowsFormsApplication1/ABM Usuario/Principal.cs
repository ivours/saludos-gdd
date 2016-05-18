using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication1.ABM_Usuario
{
    public partial class Principal : Form
    {
        public Principal()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form altaUsuario = new ABM_Usuario.CargarDatosUsuario();
            this.abrirVentana(altaUsuario);
        }

        private void abrirVentana(Form siguienteFormulario)
        {
            siguienteFormulario.Visible = true;
            this.Visible = false;
        }
    }
}
