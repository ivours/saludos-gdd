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
        String username;

        public CrearPublicacion(String username)
        {
            InitializeComponent();
            this.username = username;
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
            numericUpDown1.Value = 1;
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
            numericUpDown1.Value = 1;
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

        private String getTipo()
        {
            if (radioButton1.Checked)
                return radioButton1.Text;
            else
                return radioButton2.Text;
        }

        private int getBitCheckBox(CheckBox checkBox)
        {
            if (checkBox.Checked)
                return 1;
            else
                return 0;
        }

        private void crearPublicacion()
        {

            String tipo = this.getTipo();
            String descripcion = textBox4.Text;
            int stock = Convert.ToInt32(numericUpDown1.Value);
            decimal precio = numericUpDown2.Value;
            String rubro = textBox1.Text;
            String estado = comboBox1.SelectedItem.ToString();
            int preguntas = this.getBitCheckBox(checkBox1);
            String visibilidad = comboBox2.SelectedItem.ToString();
            int envio = this.getBitCheckBox(checkBox2);

            SQLManager manager = new SQLManager().generarSP("crearPublicacion")
                                 .agregarStringSP("@tipo", tipo)
                                 .agregarStringSP("@descripcion", descripcion)
                                 .agregarIntSP("@stock", stock)
                                 .agregarDecimalSP("@precio", precio)
                                 .agregarStringSP("@rubro", rubro)
                                 .agregarStringSP("@estado", estado)
                                 .agregarIntSP("@preguntas", preguntas)
                                 .agregarStringSP("@visibilidad", visibilidad)
                                 .agregarIntSP("@envio", envio);

            manager.ejecutarSP();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                this.crearPublicacion();
            }
            catch (Exception excepcion)
            {
                MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
            }
            
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.llenarCamposComisiones();

        }

        private void llenarCamposComisiones()
        {
            textBox7.Text = Dominio.Visibilidad.getComisionPublicacion(comboBox2.SelectedItem.ToString()).ToString();
            textBox6.Text = Dominio.Visibilidad.getComisionVenta(comboBox2.SelectedItem.ToString()).ToString();
            textBox5.Text = Dominio.Visibilidad.getComisionEnvio(comboBox2.SelectedItem.ToString()).ToString();
        }
    }
}
