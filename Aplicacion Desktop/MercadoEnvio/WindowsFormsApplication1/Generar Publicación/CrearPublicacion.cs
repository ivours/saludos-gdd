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
    public partial class CrearPublicacion : Form
    {
        public CrearPublicacion()
        {
            InitializeComponent();
            this.llenarComboBoxEstados();
            this.llenarComboBoxVisibilidades();
            comboBox1.SelectedIndex = 0;
            comboBox2.SelectedIndex = 0;
            textBox2.Text = Dominio.Fecha.getFechaActual().ToString();
            textBox3.Text = Dominio.Fecha.getFechaActual().AddDays(7).ToString();
        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            numericUpDown1.Value = 1;
            numericUpDown1.ReadOnly = true;
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            numericUpDown1.ReadOnly = false;
            numericUpDown1.Value = 0;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ABM_Rubro.ListadoRubros listadoRubros = new ABM_Rubro.ListadoRubros(this);
            listadoRubros.Show();
        }

        public void setRubro(String nombreRubro)
        {
            textBox1.Text = nombreRubro;
        }

        private void llenarComboBoxEstados()
        {
            comboBox1.Items.Add("Borrador");
            comboBox1.Items.Add("Activa");
            comboBox1.Items.Add("Pausada");
            comboBox1.Items.Add("Finalizada");
        }

        private void llenarComboBoxVisibilidades()
        {
            List<String> visibilidades = Dominio.Visibilidad.getNombresVisibilidades();

            for (int i = 0; i < visibilidades.Count; i++)
            {
                comboBox2.Items.Add(visibilidades[i]);
            }
        }

        private void limpiarCampos()
        {
            radioButton1.Select();
            textBox1.Clear();
            textBox4.Clear();
            textBox5.Clear();
            textBox6.Clear();
            textBox7.Clear();
            numericUpDown1.Value = 0;
            numericUpDown2.Value = 0;
            comboBox1.SelectedIndex = 0;
            comboBox2.SelectedIndex = 0;
            checkBox1.Checked = false;
            checkBox2.Checked = false;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }
    }
}
