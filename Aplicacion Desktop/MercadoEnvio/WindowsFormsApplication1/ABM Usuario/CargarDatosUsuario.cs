using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.ABM_Usuario
{
    public partial class CargarDatosUsuario : Form
    {
        public CargarDatosUsuario()
        {
            InitializeComponent();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (radioButton1.Checked == true)
            {
                Form cargarDatosCliente = new ABM_Usuario.CargarDatosCliente(this);
                this.abrirVentana(cargarDatosCliente);
            }
            else
            {
                Form cargarDatosEmpresa = new ABM_Usuario.CargarDatosEmpresa(this);
                this.abrirVentana(cargarDatosEmpresa);
            }
           
        }

        private void abrirVentana(Form siguienteFormulario)
        {
            siguienteFormulario.Visible = true;
            this.Visible = false;
        }
    }
}
