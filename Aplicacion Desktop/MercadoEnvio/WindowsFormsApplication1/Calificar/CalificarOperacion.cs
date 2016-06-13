using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.Calificar
{
    public partial class CalificarOperacion : Form
    {
        String username;
        String vendedor;
        int codigoPublicacion;

        public CalificarOperacion(String username, String vendedor, int codigoPublicacion)
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
            this.inicializarComboBoxEstrellas();
            this.username = username;
            this.vendedor = vendedor;
            this.codigoPublicacion = codigoPublicacion;
            this.inicializarCampos();
        }

        private void inicializarComboBoxEstrellas()
        {
            comboBox1.Items.Add(1);
            comboBox1.Items.Add(2);
            comboBox1.Items.Add(3);
            comboBox1.Items.Add(4);
            comboBox1.Items.Add(5);
            comboBox1.SelectedIndex = 0;
        }

        private void inicializarCampos()
        {
            textBox1.Text = this.vendedor;
            textBox2.Text = this.codigoPublicacion.ToString();
        }

        private void validarCampos()
        {
            this.validarDescripcion();
        }

        private void validarDescripcion()
        {
            if (textBox3.Text.Length.Equals(0))
                throw new Exception("Debe ingresar un comentario");
        }

        private void calificarPublicacion()
        {
            SQLManager manager = new SQLManager().generarSP("calificarPublicacion")
                     .agregarStringSP("@usuario", this.username)
                     .agregarIntSP("@publicacion", this.codigoPublicacion)
                     .agregarIntSP("@estrellas", (int)comboBox1.SelectedItem)
                     .agregarStringSP("@descripcion", textBox3.Text);

            manager.ejecutarSP();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                this.validarCampos();
                this.calificarPublicacion();
                this.Close();
            }
            catch (Exception excepcion)
            {
                MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
            }
            
        }
    }
}
