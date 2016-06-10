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

        private void label1_Click(object sender, EventArgs e)
        {

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
            String nombreVisibilidad = textBox4.Text;
            decimal comisionPorPublicar = numericUpDown1.Value;
            decimal comisionPorVender = numericUpDown2.Value;
            decimal comisionPorEnvio = numericUpDown3.Value;

            SQLManager manager = new SQLManager().generarSP("modificarVisibilidad")
                                 .agregarStringSP("@nombreVisibilidad", nombreVisibilidad)
                                 .agregarDecimalSP("@comisionPorPublicar", comisionPorPublicar)
                                 .agregarDecimalSP("@comisionPorVender", comisionPorVender)
                                 .agregarDecimalSP("@comisionPorEnvio", comisionPorEnvio);

            manager.ejecutarSP();
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }
    }
}
