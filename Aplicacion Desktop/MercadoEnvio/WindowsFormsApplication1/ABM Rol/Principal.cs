using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication1.ABM_Rol
{
    public partial class Principal : Form
    {

        public Principal()
        {
            InitializeComponent();
        }

        private void Form1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form alta = new ABM_Rol.Alta();
            this.abrirVentana(alta);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Form baja = new ABM_Rol.Baja();
            Form listado = new ABM_Rol.Listado(baja);
            this.abrirVentana(listado);
            //-----completar-----//
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Form modificacion = new ABM_Rol.Modificacion();
            Form listado = new ABM_Rol.Listado(modificacion);
            this.abrirVentana(listado);
        }

        private void abrirVentana(Form siguienteFormulario)
        {
            siguienteFormulario.Visible = true;
            this.Visible = false;
        }

    }
}
