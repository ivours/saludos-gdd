using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.Facturas
{
    public partial class SeleccionarFecha : Form
    {
        TextBox campoFecha;

        public SeleccionarFecha(TextBox campoFecha)
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
            this.campoFecha = campoFecha;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            campoFecha.Text = dateTimePicker1.Value.Date.ToString();
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
