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
    public partial class CargarDatosCliente : Form
    {
        Form formularioAnterior;
        String username;
        String password;

        public CargarDatosCliente(Form formularioAnterior, String username, String password)
        {
            InitializeComponent();
            this.formularioAnterior = formularioAnterior;
            this.username = username;
            this.password = password;
            this.llenarComboBoxTiposDeDocumento();
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

        private void llenarComboBoxTiposDeDocumento()
        {
            comboBox1.Items.Add("DNI");
            comboBox1.Items.Add("CI");
            comboBox1.Items.Add("LC");
            comboBox1.Items.Add("LE");
        }

        private void validarCampos()
        {
            this.validarNombre();
            this.validarApellido();
            this.validarNroDocumento();
            this.validarFechaDeNacimiento();
            this.validarEmail();
            this.validarTelefono();
            this.validarCalle();
            this.validarNroCalle();
            this.validarDepto();
            this.validarLocalidad();
            this.validarCodigoPostal();
        }

        //TODO: ver si hay que agregar alguna otra restriccion
        private void validarNombre()
        {
            if (!Validacion.estaVacio(textBox1.Text))
                throw new Exception("Debe ingresar un nombre");

            if (!Validacion.empiezaConCaracter(textBox1.Text))
                throw new Exception("El nombre debe empezar con un caracter visible");

            if(!Validacion.contieneSoloLetrasOEspacios(textBox1.Text))
                throw new Exception("El nombre debe contener únicamente letras o espacios");
        }

        private void validarApellido()
        {
            if (!Validacion.estaVacio(textBox2.Text))
                throw new Exception("Debe ingresar un apellido");

            if (!Validacion.empiezaConCaracter(textBox2.Text))
                throw new Exception("El apellido debe empezar con un caracter visible");

            if (!Validacion.contieneSoloLetrasOEspacios(textBox2.Text))
                throw new Exception("El apellido debe contener únicamente letras o espacios");
        }

        private void validarNroDocumento()
        {
            if (!Validacion.estaVacio(textBox4.Text))
                throw new Exception("Debe ingresar un nro. de documento");

            if (!Validacion.contieneSoloNumeros(textBox4.Text))
                throw new Exception("El nro. de documento debe contener únicamente números");
        }

        private void validarFechaDeNacimiento()
        {
            if (Validacion.esFechaMayorALaActual(dateTimePicker1.Value))
                throw new Exception("La fecha de nacimiento no puede ser mayor a la fecha actual");
        }

        private void validarEmail()
        {
            Extras.EmailChecker emailChecker = new Extras.EmailChecker();

            if (!Validacion.estaVacio(textBox6.Text))
                throw new Exception("Debe ingresar un E-mail");

            if (!emailChecker.IsValidEmail(textBox6.Text))
                throw new Exception("El formato del E-mail no es válido. Por favor utilice un formato correcto");
        }

        private void validarTelefono()
        {
            if (!Validacion.estaVacio(textBox7.Text))
                throw new Exception("Debe ingresar un teléfono");

            if (!Validacion.contieneSoloNumeros(textBox7.Text))
                throw new Exception("El teléfono debe contener únicamente números");
        }

        private void validarCalle()
        {
            if (!Validacion.estaVacio(textBox8.Text))
                throw new Exception("Debe ingresar una calle");

            if (!Validacion.empiezaConCaracter(textBox8.Text))
                throw new Exception("La calle debe comenzar con un caracter visible");

            if (!Validacion.contieneSoloLetrasOEspacios(textBox8.Text))
                throw new Exception("La calle debe contener únicamente letras o espacios");
        }

        private void validarNroCalle()
        {
            if (!Validacion.estaVacio(textBox9.Text))
                throw new Exception("Debe ingresar un nro. de calle");

            if (!Validacion.contieneSoloNumeros(textBox9.Text))
                throw new Exception("El nro. de calle debe contener únicamente números");
        }

        private void validarDepto()
        {
            //TODO: hacer
        }

        private void validarLocalidad()
        {
            if (!Validacion.estaVacio(textBox12.Text))
                throw new Exception("Debe ingresar una localidad");

            if (!Validacion.empiezaConCaracter(textBox12.Text))
                throw new Exception("La localidad debe comenzar con un caracter visible");

            if (!Validacion.contieneSoloLetrasOEspacios(textBox12.Text))
                throw new Exception("La localidad debe contener únicamente letras o espacios");
        }

        private void validarCodigoPostal()
        {
            if (!Validacion.estaVacio(textBox13.Text))
                throw new Exception("Debe ingresar un código postal");

            if (!Validacion.contieneSoloNumeros(textBox13.Text))
                throw new Exception("El código postal debe contener únicamente números");

            if (!textBox13.Text.Count().Equals(4))
                throw new Exception("El código postal debe estar compuesto por 4 números");
        }
        
    }
}
