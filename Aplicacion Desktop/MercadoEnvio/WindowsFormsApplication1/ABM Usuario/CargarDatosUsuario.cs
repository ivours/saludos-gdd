﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.ABM_Usuario
{
    public partial class CargarDatosUsuario : Form
    {
        public CargarDatosUsuario()
        {
            InitializeComponent();
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
                    Form cargarDatosCliente = new ABM_Usuario.CargarDatosCliente(this, textBox1.Text, textBox2.Text);
                    this.abrirVentana(cargarDatosCliente);
                }
                catch (Exception excepcion)
                {
                    MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
                    this.limpiarCampos();
                }

                
            }
            else
            {
                Form cargarDatosEmpresa = new ABM_Usuario.CargarDatosEmpresa(this);
                this.abrirVentana(cargarDatosEmpresa);
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
                throw new Exception("El username debe empezar con un caracter visible");

            if (!Validacion.tieneLongitudMayorOIgualA(textBox1.Text, 4))
                throw new Exception("El username debe tener al menos 4 caracteres");
        }

        private void validarPassword()
        {
            if (Validacion.contieneEspacio(textBox2.Text))
                throw new Exception("La password no debe contener espacios");

            if (Validacion.estaVacio(textBox2.Text))
                throw new Exception("Debe ingresar una password");

            if (Validacion.estaVacio(textBox3.Text))
                throw new Exception("Debe re-ingresar la password");

            if (Validacion.tieneLongitudMayorOIgualA(textBox2.Text, 4))
                throw new Exception("La password debe contener al menos 4 caracteres");

            if (!textBox2.Text.Equals(textBox3.Text))
                throw new Exception("Las passwords no coinciden");
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
    }
}
