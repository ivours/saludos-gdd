using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.Generar_Publicación
{
    public partial class CambiarEstadoPublicacion : Form
    {
        int codigoPublicacion;
        String estadoActual;

        public CambiarEstadoPublicacion()
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
        }

        private void cambiarEstadoPublicacion()
        {
            String nuevoEstado = comboBox1.SelectedItem.ToString();

            SQLManager manager = new SQLManager().generarSP("cambiarEstadoPublicacion")
                                 .agregarIntSP("@codPublicacion", this.codigoPublicacion)
                                 .agregarStringSP("@nuevoEstado", nuevoEstado);

            manager.ejecutarSP();
        }
        
        private void finalizarPublicacionPorUsuario()
        {
            String nuevoEstado = comboBox1.SelectedItem.ToString();

            SQLManager manager = new SQLManager().generarSP("finalizarPublicacionPorUsuario")
                                 .agregarIntSP("@codPublicacion", this.codigoPublicacion);

            manager.ejecutarSP();
        }

        private void activarPublicacionPorPrimeraVez()
        {
            String nuevoEstado = comboBox1.SelectedItem.ToString();

            SQLManager manager = new SQLManager().generarSP("activarPublicacionPorPrimeraVez")
                                 .agregarIntSP("@codPublicacion", this.codigoPublicacion);

            manager.ejecutarSP();
        }

        public void setCodigoPublicacion(int codigoPublicacion)
        {
            this.codigoPublicacion = codigoPublicacion;
        }

        public void setEstadoActual(String estadoActual)
        {
            this.estadoActual = estadoActual;
            this.llenarComboBoxEstados();
        }

        //Lleno el comboBox de estados con las distintas opciones permitidas segun el estado actual de la publicacion
        //Inicializo como item seleccionado del comboBox al estado actual de la publicacion
        private void llenarComboBoxEstados()
        {
            switch (this.estadoActual)
            {
                case "Borrador":
                    comboBox1.Items.Add("Borrador");
                    comboBox1.Items.Add("Activa");
                    comboBox1.SelectedIndex = 0;
                    break;

                case "Activa":
                    comboBox1.Items.Add("Activa");
                    comboBox1.Items.Add("Pausada");
                    comboBox1.Items.Add("Finalizada");
                    comboBox1.SelectedIndex = 0;
                    break;

                case "Pausada":
                    comboBox1.Items.Add("Pausada");
                    comboBox1.Items.Add("Activa");
                    comboBox1.Items.Add("Finalizada");
                    comboBox1.SelectedIndex = 0;
                    break;

                case "Finalizada":
                    comboBox1.Items.Add("Finalizada");
                    comboBox1.SelectedIndex = 0;
                    break;
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (comboBox1.SelectedItem.ToString() == "Finalizada")
                this.finalizarPublicacionPorUsuario();
            else
            {
                if (this.estadoActual == "Borrador" && comboBox1.SelectedItem.ToString() == "Activa")
                    this.activarPublicacionPorPrimeraVez();
                else
                    this.cambiarEstadoPublicacion();
            }

            this.Close();
        }
    }
}
