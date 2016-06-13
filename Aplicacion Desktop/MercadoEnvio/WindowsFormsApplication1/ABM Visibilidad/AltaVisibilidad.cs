using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.ABM_Visibilidad
{
    public partial class AltaVisibilidad : Form
    {
        public AltaVisibilidad()
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void limpiarCampos()
        {
            numericUpDown1.Value = 0;
            numericUpDown2.Value = 0;
            numericUpDown3.Value = 0;
            textBox4.Clear();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

        private void altaVisibilidad()
        {
            String nombreVisibilidad = textBox4.Text;
            decimal comisionPorPublicar = numericUpDown1.Value;
            decimal comisionPorVender = numericUpDown2.Value / 100;
            decimal comisionPorEnvio = numericUpDown3.Value / 100;

            SQLManager manager = new SQLManager().generarSP("altaVisibilidad")
                                 .agregarStringSP("@nombre_visibilidad", nombreVisibilidad)
                                 .agregarDecimalSP("@comision_publicacion", comisionPorPublicar)
                                 .agregarDecimalSP("@comision_venta", comisionPorVender)
                                 .agregarDecimalSP("@comision_envio", comisionPorEnvio);

            manager.ejecutarSP();
        }

        private void validarCampos()
        {
            this.validarNombre();
            this.validarComisiones();
        }

        private void validarNombre()
        {
            if (Validacion.estaVacio(textBox4.Text))
                throw new Exception("Debe ingresar un nombre");

            if (!Validacion.empiezaConCaracter(textBox4.Text))
                throw new Exception("El nombre debe empezar con un caracter visible");

            if (!Validacion.contieneSoloLetrasOEspacios(textBox4.Text))
                throw new Exception("El nombre debe contener únicamente letras o espacios");
        
        }

        private void validarComisiones()
        {
            if (!Validacion.esIgualOMenorACien(numericUpDown2.Value) || !Validacion.esIgualOMenorACien(numericUpDown3.Value))
                throw new Exception("Las comisiones no pueden exceder el 100%");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                this.validarCampos();
                this.altaVisibilidad();

                this.Close();
            }
            catch (Exception excepcion)
            {
                MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
            }
        }
    }
}
