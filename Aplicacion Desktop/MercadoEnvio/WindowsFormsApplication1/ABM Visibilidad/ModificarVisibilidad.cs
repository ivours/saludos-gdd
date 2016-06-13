using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.ABM_Visibilidad
{
    public partial class ModificarVisibilidad : Form
    {
        int codigoVisibilidad;
        String nombreVisibilidad;
        decimal comisionPorPublicar;
        decimal comisionPorVender;
        decimal comisionPorEnvio;

        public ModificarVisibilidad()
        {
            InitializeComponent();
        }

        private void limpiarCampos()
        {
            numericUpDown1.Value = 0;
            numericUpDown2.Value = 0;
            numericUpDown3.Value = 0;
            textBox4.Clear();
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

            MessageBox.Show("validandin");
        }

        private void validarComisiones()
        {
            if (!Validacion.esIgualOMenorACien(numericUpDown2.Value) || !Validacion.esIgualOMenorACien(numericUpDown3.Value))
                throw new Exception("Las comisiones no pueden exceder el 100%");

            MessageBox.Show("validandin");
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
        
        public void setCodigoVisibilidad(int codigoVisibilidad)
        {
            this.codigoVisibilidad = codigoVisibilidad;
        }

        public void setNombreVisibilidad(String nombreVisibilidad)
        {
            this.nombreVisibilidad = nombreVisibilidad;
            textBox4.Text = nombreVisibilidad;
        }

        public void setComisionPorPublicar(decimal comisionPorPublicar)
        {
            this.comisionPorPublicar = comisionPorPublicar;
            numericUpDown1.Value = comisionPorPublicar;
        }

        public void setComisionPorVender(decimal comisionPorVender)
        {
            this.comisionPorVender = comisionPorVender;
            numericUpDown2.Value = comisionPorVender;
        }

        public void setComisionPorEnvio(decimal comisionPorEnvio)
        {
            this.comisionPorEnvio = comisionPorEnvio;
            numericUpDown3.Value = comisionPorEnvio;
        }

        private void modificarVisibilidad()
        {
            int codigo = this.codigoVisibilidad;
            String nombreVisibilidad = textBox4.Text;
            decimal comisionPorPublicar = numericUpDown1.Value;
            decimal comisionPorVender = numericUpDown2.Value / 100;
            decimal comisionPorEnvio = numericUpDown3.Value / 100;
            MessageBox.Show("modificainding");
            SQLManager manager = new SQLManager().generarSP("modificarVisibilidad")
                                 .agregarIntSP("@codigo", codigo)
                                 .agregarStringSP("@nombre_visibilidad", nombreVisibilidad)
                                 .agregarDecimalSP("@comision_publicacion", comisionPorPublicar)
                                 .agregarDecimalSP("@comision_venta", comisionPorVender)
                                 .agregarDecimalSP("@comision_envio", comisionPorEnvio);

            manager.ejecutarSP();
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

        private void label7_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            try
            {
                this.validarCampos();
                this.modificarVisibilidad();

                this.Close();
            }
            catch (Exception excepcion)
            {
                MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
            }
        }
    }
}
