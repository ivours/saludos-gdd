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
    public partial class CargarDatosEmpresa : Form
    {
        Form formularioAnterior;

        public CargarDatosEmpresa(Form formularioAnterior)
        {
            InitializeComponent();
            this.formularioAnterior = formularioAnterior;
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.abrirVentana(formularioAnterior);
        }

        private void abrirVentana(Form siguienteFormulario)
        {
            siguienteFormulario.Visible = true;
            this.Visible = false;
        }

        //TODO: ver si puede incluir cualquier caracter o no
        private void validarRazonSocial()
        {
            if (Validacion.estaVacio(textBox1.Text))
                throw new Exception("Debe ingresar una razón social");

            if (!Validacion.empiezaConCaracter(textBox1.Text))
                throw new Exception("La razón social debe empezar con un caracter visible");
        }

        private void validarNombreDeContacto()
        {
            if (Validacion.estaVacio(textBox3.Text))
                throw new Exception("Debe ingresar un nombre de contacto");

            if (!Validacion.empiezaConCaracter(textBox3.Text))
                throw new Exception("El nombre de contacto debe empezar con un caracter visible");

            if (!Validacion.contieneSoloLetrasOEspacios(textBox3.Text))
                throw new Exception("El nombre de contacto debe contener únicamente letras o espacios");
        }

        private void validarCuit()
        {
            if (Validacion.estaVacio(textBox4.Text))
                throw new Exception("Debe ingresar un CUIT");

            if (!Validacion.tieneFormatoDeCuit(textBox4.Text))
                throw new Exception("El formato de CUIT ingresado no es válido. El CUIT debe estar compuesto por números y guiones");
        }

        private void validarEmail()
        {
            Extras.EmailChecker emailChecker = new Extras.EmailChecker();

            if (Validacion.estaVacio(textBox6.Text))
                throw new Exception("Debe ingresar un E-mail");

            if (!emailChecker.IsValidEmail(textBox6.Text))
                throw new Exception("El formato del E-mail no es válido. Por favor utilice un formato correcto");
        }

        private void validarTelefono()
        {
            if (Validacion.estaVacio(textBox7.Text))
                throw new Exception("Debe ingresar un teléfono");

            if (!Validacion.contieneSoloNumeros(textBox7.Text))
                throw new Exception("El teléfono debe contener únicamente números");
        }

        private void validarCalle()
        {
            if (Validacion.estaVacio(textBox8.Text))
                throw new Exception("Debe ingresar una calle");

            if (!Validacion.empiezaConCaracter(textBox8.Text))
                throw new Exception("La calle debe comenzar con un caracter visible");

            if (!Validacion.contieneSoloLetrasOEspacios(textBox8.Text))
                throw new Exception("La calle debe contener únicamente letras o espacios");
        }

        private void validarNroCalle()
        {
            if (Validacion.estaVacio(textBox9.Text))
                throw new Exception("Debe ingresar un nro. de calle");

            if (!Validacion.contieneSoloNumeros(textBox9.Text))
                throw new Exception("El nro. de calle debe contener únicamente números");
        }

        private void validarDepto()
        {
            if (Validacion.estaVacio(textBox11.Text))
                throw new Exception("Debe ingresar un depto.");

            if (!Validacion.contieneSoloLetras(textBox11.Text))
                throw new Exception("El depto. debe ser una letra");
        }

        private void validarLocalidad()
        {
            if (Validacion.estaVacio(textBox12.Text))
                throw new Exception("Debe ingresar una localidad");

            if (!Validacion.empiezaConCaracter(textBox12.Text))
                throw new Exception("La localidad debe comenzar con un caracter visible");

            if (!Validacion.contieneSoloLetrasOEspacios(textBox12.Text))
                throw new Exception("La localidad debe contener únicamente letras o espacios");
        }

        private void validarCodigoPostal()
        {
            if (Validacion.estaVacio(textBox13.Text))
                throw new Exception("Debe ingresar un código postal");

            if (!Validacion.contieneSoloNumeros(textBox13.Text))
                throw new Exception("El código postal debe contener únicamente números");

            if (!textBox13.Text.Count().Equals(4))
                throw new Exception("El código postal debe estar compuesto por 4 números");
        }


    }
}
