using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.ABM_Rol
{
    public partial class Listado : Form
    {

        Form siguienteFormulario;

        public Listado(Form formulario)
        {
            this.siguienteFormulario = formulario;
            InitializeComponent();
        }

        private void Listado_Load(object sender, EventArgs e)
        {

        }
    }
}
