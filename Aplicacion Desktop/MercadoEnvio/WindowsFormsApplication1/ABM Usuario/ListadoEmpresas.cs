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
    public partial class ListadoEmpresas : Form
    {
        public ListadoEmpresas()
        {
            InitializeComponent();
            ConfiguradorDataGrid.configurar(dataGridView1);
        }

        private void limpiarCampos()
        {
            textBox1.Clear();
            textBox2.Clear();
            textBox3.Clear();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
