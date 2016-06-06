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
        Form formAnterior;

        public Listado(Form formAnterior)
        {
            InitializeComponent();
            this.formAnterior = formAnterior;
        }

        private void Listado_Load(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            String nombreRol;
            int idRol;

            switch (formAnterior.Name)
            {
                case "CargarDatosUsuario":
                    idRol = (int) dataGridView1.SelectedRows[0].Cells[0].Value;
                    nombreRol = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                    (formAnterior as ABM_Usuario.CargarDatosUsuario).setRol(nombreRol,idRol);
                    break;
            }

            this.Close();
        }
    }
}
