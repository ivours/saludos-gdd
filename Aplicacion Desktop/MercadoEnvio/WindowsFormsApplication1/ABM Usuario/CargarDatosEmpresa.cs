using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Dominio;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.ABM_Usuario
{
    public partial class CargarDatosEmpresa : Form
    {
        Form formularioAnterior;
        String username;
        String password;
        int idRol;
        int idRubro;

        public CargarDatosEmpresa(Form formularioAnterior, String username, String password, int idRol)
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
            this.formularioAnterior = formularioAnterior;
            this.username = username;
            this.password = password;
            this.idRol = idRol;
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                this.validarCampos();
                this.altaUsuarioEmpresa();
                MessageBox.Show("Empresa creada exitosamente.");
                this.Close();
            }
            catch (Exception excepcion)
            {
                MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
            }
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

        private void validarCampos()
        {
            this.validarRazonSocial();
            this.validarNombreDeContacto();
            this.validarCuit();
            this.validarEmail();
            this.validarTelefono();
            this.validarCiudad();
            this.validarCalle();
            this.validarNroCalle();
            this.validarDepto();
            this.validarLocalidad();
            this.validarCodigoPostal();

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

        private void button3_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

        private void validarCiudad()
        {
            if (Validacion.estaVacio(textBox2.Text))
                throw new Exception("Debe ingresar una ciudad");

            if (!Validacion.empiezaConCaracter(textBox2.Text))
                throw new Exception("La ciudad debe comenzar con un caracter visible");

            if (!Validacion.contieneSoloLetrasOEspacios(textBox2.Text))
                throw new Exception("La ciudad debe contener únicamente letras o espacios");
        }

        private void limpiarCampos()
        {
            textBox1.Clear(); 
            textBox3.Clear();
            textBox4.Clear();
            textBox5.Clear();
            textBox6.Clear();
            textBox7.Clear();
            textBox8.Clear();
            textBox9.Clear();
            textBox11.Clear();
            textBox12.Clear();
            textBox13.Clear();
            numericUpDown1.Value = 0;
        }

        private void altaUsuarioEmpresa()
        {
            String razonSocial = textBox1.Text;
            String nombreDeContacto = textBox3.Text;
            String cuit = textBox4.Text;
            String email = textBox6.Text;
            int telefono = Convert.ToInt32(textBox7.Text);
            String ciudad = textBox2.Text;
            String calle = textBox8.Text;
            int nroCalle = Convert.ToInt32(textBox9.Text);
            int piso = Convert.ToInt32(numericUpDown1.Value);
            String depto = textBox11.Text;
            String localidad = textBox12.Text;
            String codigoPostal = textBox13.Text;

            SQLManager manager = new SQLManager().generarSP("altaUsuarioEmpresa")
                                 .agregarStringSP("@username", username)
                                 .agregarStringSP("@password", password)
                                 .agregarIntSP("@id_rol", idRol)
                                 .agregarStringSP("@razon_social", razonSocial)
                                 .agregarStringSP("@cuit", cuit)
                                 .agregarStringSP("@mail", email)
                                 .agregarIntSP("@telefono", telefono)
                                 .agregarStringSP("@calle", calle)
                                 .agregarIntSP("@nro_calle", nroCalle)
                                 .agregarIntSP("@piso", piso)
                                 .agregarStringSP("@depto", depto)
                                 .agregarStringSP("@ciudad", ciudad)
                                 .agregarStringSP("@contacto", nombreDeContacto)
                                 .agregarStringSP("@cod_postal", codigoPostal)
                                 .agregarStringSP("@localidad", localidad)
                                 .agregarIntSP("@id_rubro", idRubro);

            manager.ejecutarSP();
        }

        public void setRubroPrincipal(String nombreRubro)
        {
            textBox5.Text = nombreRubro;
            this.idRubro = Rubro.getIdRubro(nombreRubro);
        }

        private void button4_Click(object sender, EventArgs e)
        {
            ABM_Rubro.ListadoRubros listadoRubros = new ABM_Rubro.ListadoRubros(this);
            listadoRubros.Show();
        }
    }
}
