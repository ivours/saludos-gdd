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
    public partial class ModificarDatosEmpresa : Form
    {
        public ModificarDatosEmpresa()
        {
            InitializeComponent();
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {

        }

        public void setRazonSocial(String razonSocial)
        {
            textBox1.Text = razonSocial;
        }

        public void setNombreDeContacto(String nombreDeContacto)
        {
            textBox3.Text = nombreDeContacto;
        }

        public void setCuit(String cuit)
        {
            textBox4.Text = cuit;
        }

        public void setRubroPrincipal(String rubroPrincipal)
        {
            textBox5.Text = rubroPrincipal;
        }

        public void setEmail(String email)
        {
            textBox6.Text = email;
        }

        public void setTelefono(String telefono)
        {
            textBox7.Text = telefono;
        }

        public void setCiudad(String ciudad)
        {
            textBox2.Text = ciudad;
        }

        public void setCalle(String calle)
        {
            textBox8.Text = calle;
        }

        public void setNroCalle(String nroCalle)
        {
            textBox9.Text = nroCalle;
        }

        public void setPiso(decimal piso)
        {
            numericUpDown1.Value = piso;
        }

        public void setDepto(String depto)
        {
            textBox11.Text = depto;
        }

        public void setLocalidad(String localidad)
        {
            textBox12.Text = localidad;
        }

        public void setCodigoPostal(String codigoPostal)
        {
            textBox13.Text = codigoPostal;
        }
    }
}
