using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.ABM_Usuario
{
    public partial class CargarDatosUsuario : Form
    {
        int idRol;

        public CargarDatosUsuario()
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (radioButton1.Checked.Equals(true))
            {
                try
                {
                    this.validarCampos();
                    Form cargarDatosCliente = new ABM_Usuario.CargarDatosCliente(this, textBox1.Text, textBox2.Text, idRol);
                    this.abrirVentana(cargarDatosCliente);
                }
                catch (Exception excepcion)
                {
                    MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
                }

                
            }
            else
            {
                try
                {
                    this.validarCampos();
                    Form cargarDatosEmpresa = new ABM_Usuario.CargarDatosEmpresa(this, textBox1.Text, textBox2.Text, idRol);
                    this.abrirVentana(cargarDatosEmpresa);
                }
                catch (Exception excepcion)
                {
                    MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
                }
            }
           
        }

        private void abrirVentana(Form siguienteFormulario)
        {
            siguienteFormulario.Visible = true;
            this.Visible = false;
        }

        private void validarUsername()
        {
            if(Validacion.estaVacio(textBox1.Text))
                throw new Exception("Debe ingresar un username");

            if (!Validacion.empiezaConCaracter(textBox1.Text))
            {
                this.limpiarUsername();
                throw new Exception("El username debe empezar con un caracter visible");
            }

            if (!Validacion.tieneLongitudMayorOIgualA(textBox1.Text, 4))
            {
                this.limpiarUsername();
                throw new Exception("El username debe tener al menos 4 caracteres");
            }
        }

        private void limpiarUsername()
        {
            textBox1.Clear();
        }


        private void limpiarPassword()
        {
            textBox2.Clear();
            textBox3.Clear();
        }

        private void validarPassword()
        {
            if (Validacion.contieneEspacio(textBox2.Text))
            {
                this.limpiarPassword();
                throw new Exception("La password no debe contener espacios");
            }

            if (Validacion.estaVacio(textBox2.Text))
                throw new Exception("Debe ingresar una password");

            if (Validacion.estaVacio(textBox3.Text))
                throw new Exception("Debe re-ingresar la password");

            if (!Validacion.tieneLongitudMayorOIgualA(textBox2.Text, 4))
            {
                this.limpiarPassword();
                throw new Exception("La password debe contener al menos 4 caracteres");
            }

            if (!textBox2.Text.Equals(textBox3.Text))
            {
                this.limpiarPassword();
                throw new Exception("Las passwords no coinciden");
            }
        }

        private void validarCampos()
        {
            this.validarUsername();
            this.validarPassword();
        }

        private void limpiarCampos()
        {
            textBox1.Clear();
            textBox2.Clear();
            textBox3.Clear();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            ABM_Rol.ListadoRoles listadoRoles = new ABM_Rol.ListadoRoles(this);
            listadoRoles.Show();
        }

        public void setRol(String nombreRol, int idRol)
        {
            textBox4.Text = nombreRol;
            this.idRol = idRol;
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            textBox4.Text = "Cliente";
            idRol = Dominio.Rol.getIdRol("Cliente");
        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            textBox4.Text = "Empresa";
            idRol = Dominio.Rol.getIdRol("Empresa");
        }
    }
}
